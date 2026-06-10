.PHONY: build kube play down workspace install upgrade uninstall tls auth-codex

NAMESPACE=workspace
SERVER=192.168.1.137
SSH_KEY_DIR := ./infrastructure/secrets/ssh-tunnel
SSH_KEY := $(SSH_KEY_DIR)/id_ed25519_tunnel
SSH_USER ?= PrivacyPerfect
CHROME_PATH=/mnt/c/Users/PrivacyPerfect/AppData/Local/Chromium/Application/chrome.exe

podman-machine-start:
	@podman.exe machine start

# Generate deployment from Helm Chart
kube:
	@podman run -it --rm -v ./infrastructure:/infrastructure:Z -w /infrastructure docker.io/alpine/helm:latest template ${NAMESPACE} --dry-run=client --values ./values.yaml . > ./infrastructure/kube.yaml

# Run the deployment with Podman
play:
	@podman kube play --replace ./infrastructure/kube.yaml
	@podman pod ls | grep ${NAMESPACE}

# Stop the deployment with Podman
down:
	@podman kube down ./infrastructure/kube.yaml
	@podman volume rm ${NAMESPACE}-gateway

# Build containers, Generate deployment and Run the deployment with Podman
workspace:
	@make kube
	@make play

expose-podman-api:
	@podman system service --time=0 tcp://0.0.0.0:2375

jappa:
	@cp ~/.ssh/id_ed25519 ./infrastructure/secrets/codium/id_privatekey

# Generate a Certificate
tls:
	@podman run -it --rm \
	-e DOMAIN=localhost \
	-e COUNTRY=US \
	-e STATE=workspace \
	-e CITY=workspace \
	-e ORGANIZATION=workspace \
	-v ./infrastructure/secrets/gateway:/certs:Z \
	docker.io/alpine/openssl:latest req -x509 -noenc -days 365 -newkey rsa:2048 -keyout /certs/tls.key -out /certs/tls.crt -subj "/C=US/ST=workspace/L=workspace/O=workspace/CN=localhost" -addext "subjectAltName=DNS:localhost,DNS:*.localhost"

auth-codex:
	@podman run --rm -it \
	--name codex-debug \
	-p 1455:1455 \
	--user 0:0 \
	-v ./infrastructure/secrets/codex:/workspace/.config/codex:Z \
	docker.io/photoprism/codex:latest

opencode:
	@podman exec -it workspace-opencode-pod-opencode-server opencode

openclaw:
	@podman exec -it workspace-openclaw-pod-openclaw bash

connect-provider:
	@podman run -it -p 1455:1455 -v ./infrastructure/secrets/opencode:/home/core/.local/share/opencode localhost/core:latest bash

wsl-ip:
	@wsl.exe hostname -I | awk '{print $1}' | tr -d '\r'

# Copy the certificate from the proxy container
ssh-tunnel-key:
	@mkdir -p $(SSH_KEY_DIR)
	@[ -f $(SSH_KEY) ] || ssh-keygen -t ed25519 -N "" -f $(SSH_KEY) -C "alex-tunnel-key"
	@chmod 600 $(SSH_KEY)

ssh-copy-id-linux:
	@ssh-copy-id -f -i ./infrastructure/secrets/ssh-tunnel/id_ed25519_tunnel.pub PrivacyPerfect@${SERVER}

ssh-copy-id-windows:
	@cat $(SSH_KEY).pub | ssh $(SSH_USER)@$(SERVER) 'powershell -NoProfile -ExecutionPolicy Bypass -Command "$$key = [Console]::In.ReadToEnd().Trim(); New-Item -ItemType File -Force -Path \"C:\ProgramData\ssh\administrators_authorized_keys\" | Out-Null; $$existing = if (Test-Path \"C:\ProgramData\ssh\administrators_authorized_keys\") { Get-Content \"C:\ProgramData\ssh\administrators_authorized_keys\" -Raw } else { \"\" }; if ($$existing -notmatch [regex]::Escape($$key)) { Add-Content -Path \"C:\ProgramData\ssh\administrators_authorized_keys\" -Value $$key }; icacls \"C:\ProgramData\ssh\administrators_authorized_keys\" /inheritance:r | Out-Null; icacls \"C:\ProgramData\ssh\administrators_authorized_keys\" /grant \"Administrators:F\" \"SYSTEM:F\" | Out-Null; Restart-Service sshd"'
	@ssh -o IdentitiesOnly=yes -i $(SSH_KEY) $(SSH_USER)@$(SERVER)

chromium-debug:
	@$(CHROME_PATH)  \
	--remote-debugging-port=9222 \
	--user-data-dir="%TEMP%\chromium-debug-profile" \
	--no-first-run \
	--no-default-browser-check \
	--disable-first-run-ui \
	--disable-search-engine-choice-screen \
	--disable-popup-blocking \
	--disable-extensions \
	--disable-background-networking \
	--disable-background-timer-throttling \
	--disable-renderer-backgrounding \
	--disable-backgrounding-occluded-windows \
	--disable-features=Translate,MediaRouter,OptimizationHints,AutofillServerCommunication \
	--metrics-recording-only \
	--safebrowsing-disable-auto-update \
	about:blank
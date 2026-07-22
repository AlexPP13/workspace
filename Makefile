.PHONY: kube play down workspace clean certificate

NAMESPACE=workspace
USERNS=--userns=host

podman-machine-start:
	@podman.exe machine start

expose-podman-api:
	@podman system service --time=0 tcp://0.0.0.0:2375

fix-permissions:
	@sudo chgrp -R 0 /mnt/wsl/Development/
	@sudo chmod -R g+rwX /mnt/wsl/Development/

login:
	@podman run --rm --network=host --user 1001:0 -it \
		--mount type=volume,src=$(NAMESPACE)-opencode-opencode,dst=/home/core/.local,volume-subpath=.local \
		--mount type=volume,src=$(NAMESPACE)-opencode-opencode,dst=/home/core/.cache,volume-subpath=.cache \
		--mount type=volume,src=$(NAMESPACE)-opencode-opencode,dst=/home/core/.config,volume-subpath=.config \
		-v $(CURDIR)/infrastructure/configs/opencode/opencode.json:/home/core/.config/opencode/opencode.json:ro,Z \
		ghcr.io/alexstorm1313/core:latest opencode mcp auth figma
	@podman run --rm --network=host --user 1001:0 -it \
		--mount type=volume,src=$(NAMESPACE)-opencode-opencode,dst=/home/core/.local,volume-subpath=.local \
		--mount type=volume,src=$(NAMESPACE)-opencode-opencode,dst=/home/core/.cache,volume-subpath=.cache \
		--mount type=volume,src=$(NAMESPACE)-opencode-opencode,dst=/home/core/.config,volume-subpath=.config \
		-v $(CURDIR)/infrastructure/configs/opencode/opencode.json:/home/core/.config/opencode/opencode.json:ro,Z \
		ghcr.io/alexstorm1313/core:latest opencode mcp auth rovo
	@podman run --rm --network=host --user 1001:0 -it \
		--mount type=volume,src=$(NAMESPACE)-opencode-opencode,dst=/home/core/.local,volume-subpath=.local \
		--mount type=volume,src=$(NAMESPACE)-opencode-opencode,dst=/home/core/.cache,volume-subpath=.cache \
		--mount type=volume,src=$(NAMESPACE)-opencode-opencode,dst=/home/core/.config,volume-subpath=.config \
		-v $(CURDIR)/infrastructure/configs/opencode/opencode.json:/home/core/.config/opencode/opencode.json:ro,Z \
		ghcr.io/alexstorm1313/core:latest opencode auth login --provider openai

# Generate deployment from Helm Chart
kube:
	@podman run -i --rm -v ./infrastructure:/infrastructure:Z -w /infrastructure --entrypoint sh docker.io/alpine/helm:latest -c 'helm template ${NAMESPACE} --dry-run=client --values ./values.yaml . > ./kube.yaml.tmp && mv ./kube.yaml.tmp ./kube.yaml'

play:
	@podman kube play --replace $(USERNS) ./infrastructure/kube.yaml
	@GATEWAY_INFRA=$$(podman pod inspect --format '{{.InfraContainerID}}' workspace-gateway-pod); \
	podman network disconnect --force podman-default-kube-network $$GATEWAY_INFRA; \
	podman network connect \
		--alias alex.pp.workspace-gateway-pod \
		podman-default-kube-network $$GATEWAY_INFRA
	@podman pod ls | grep ${NAMESPACE}

# Stop the deployment with Podman
down:
	@podman kube down --force ./infrastructure/kube.yaml

# Build containers, Generate deployment and Run the deployment with Podman
workspace:
	@make down
	@make kube
	@make play

# Remove all volumes
clean:
	@podman volume ls --quiet --filter 'name=^${NAMESPACE}-' | xargs -r podman volume rm --force

# Generate a Certificate
certificate:
	@podman run -it --rm \
	-e DOMAIN=localhost \
	-e COUNTRY=US \
	-e STATE=workspace \
	-e CITY=workspace \
	-e ORGANIZATION=workspace \
	-v ./secrets:/certs:Z \
	docker.io/alpine/openssl:latest req -x509 -noenc -days 365 -newkey rsa:2048 -keyout /certs/tls.key -out /certs/tls.crt -subj "/C=US/ST=workspace/L=workspace/O=workspace/CN=localhost" -addext "subjectAltName=DNS:localhost,DNS:*.localhost"

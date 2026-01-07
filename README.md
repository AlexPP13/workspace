# Project Deployment Guide

This project uses a Makefile to automate deployment and management using Podman and Helm. It supports local development using Podman.

## Prerequisites

- [Podman](https://podman.io/) installed for container management

## Environment Variables

Before using the Makefile, set the following environment variables as needed:

- `NAMESPACE`: Workspace namespace (default: workspace)

## Available Commands

### Local Development Commands

- `make kube`
  - Generates Kubernetes deployment files from Helm charts
  - Creates `kube.yaml` using values from `values.yaml` and `values.podman.yaml`

- `make play`
  - Deploys the application locally using Podman
  - Uses the generated `kube.yaml` file

- `make down`
  - Stops the local deployment
  - Removes all resources defined in `kube.yaml`

- `make workspace`
  - Convenience command that runs `build`, `kube`, and `play` in sequence
  - Complete local development setup in one command

### Utility Commands

- `make cert`
  - Copies the SSL certificate from the proxy container
  - Extracts from `/etc/nginx/certificates/certificate.crt`
  - Saves to the local directory

## Configuration Files

The project expects the following configuration files:

- `values.yaml`: Base Helm values
- `values.podman.yaml`: Podman-specific configuration values

## Usage Examples

1. Local development workflow:
```bash
# Start the complete local environment
make workspace

# When finished, tear down the environment
make down
```
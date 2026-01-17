# n8n Production Deployment

This repository contains the infrastructure code and automation scripts to deploy a production-grade n8n instance on Ubuntu 24.04 (Optimized for OVH Cloud).

## Features
- **Ubuntu 24.04 Hardening:** UFW firewall and SSH security.
- **Docker Compose Orchestration:** n8n, PostgreSQL 16, and Traefik v3.
- **SSL Management:** Automatic certificates via Let's Encrypt.
- **Performance:** n8n Queue mode enabled.

## Prerequisites
- A virtual machine running Ubuntu 24.04.
- A public domain name pointing to the server's IP.
- Root or sudo access.

## Quick Start Deployment

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/n8n-deploy.git
cd n8n-deploy
```

### 2. Prepare the Host
Execute the hardening scripts in order:
```bash
chmod +x scripts/*.sh
sudo ./scripts/setup_host.sh
sudo ./scripts/install_docker.sh
sudo ./scripts/setup_firewall.sh
sudo ./scripts/secure_ssh.sh
```
**CRITICAL:** After running `secure_ssh.sh`, verify access in a new terminal using `ssh -p 2222 user@host` before closing your current session.

### 3. Configure Environment
```bash
cp docker/.env.example docker/.env
nano docker/.env
```
Update `DOMAIN_NAME`, `SSL_EMAIL`, and database credentials.

### 4. Deploy Services
```bash
cd docker
docker compose up -d
```

## Maintenance & Backups
- **Logs:** `docker compose logs -f`
- **Updates:** Update image tags in `docker-compose.yml` and run `docker compose pull && docker compose up -d`.
- **Backups:** Backup the `docker/postgres_data` and `docker/n8n_data` volumes regularly.

## Directory Structure
- `docker/`: Docker Compose and environment templates.
- `scripts/`: OS hardening and installation scripts.
- `traefik/`: Traefik static configuration.
- `conductor/`: Project management and specifications.

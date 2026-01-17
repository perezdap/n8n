# Specification: Deploy n8n Core Infrastructure

## 1. Overview
This track focuses on the foundational deployment of a production-grade n8n instance on Ubuntu 24.04. It includes OS hardening, Docker Compose orchestration for n8n and PostgreSQL, and Traefik v3 for reverse proxying and SSL management.

## 2. Goals
- Secure the Ubuntu host (UFW, SSH hardening).
- Deploy n8n (Queue mode) and PostgreSQL 16 using Docker Compose.
- Configure Traefik v3 with automated Let's Encrypt SSL.
- Ensure the setup is resilient and production-ready.

## 3. Requirements

### 3.1 OS Hardening
- **UFW:** Enable and allow only ports 80, 443, and custom SSH port (2222).
- **SSH:** Change default port to 2222, disable root login, enforce key-based auth.
- **Docker:** Configure for non-root execution.

### 3.2 Docker Infrastructure
- **Network:** Create isolated bridge networks for backend (n8n <-> Postgres) and frontend (Traefik <-> n8n).
- **Volumes:** Persist n8n data, Postgres data, and Traefik certificates.

### 3.3 Services
- **n8n:**
    - Image: `n8nio/n8n:1.x` (Pinned minor version).
    - Environment: `N8N_RUNNERS_ENABLED=true`, `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true`.
- **PostgreSQL:**
    - Image: `postgres:16`.
    - Configuration: Standard production tuning (optional for MVP).
- **Traefik:**
    - Image: `traefik:v3`.
    - Configuration: Static config for entrypoints (web, websecure), Dynamic config for routers/services, ACME (Let's Encrypt) resolver.

## 4. Acceptance Criteria
- [ ] SSH access is only possible via port 2222 with keys.
- [ ] UFW blocks all other unneeded inbound traffic.
- [ ] `docker compose up -d` starts all services without error.
- [ ] n8n is accessible via HTTPS (valid Let's Encrypt cert).
- [ ] n8n connects successfully to the PostgreSQL database.

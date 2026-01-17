# Implementation Plan - Deploy n8n Core Infrastructure

## Phase 1: Host Preparation & Hardening [checkpoint: 0f73051]
- [x] Task: Create `scripts/setup_host.sh` for initial OS updates and dependencies. [50531ac]
    - [ ] Sub-task: Write script to update apt, install curl, git, ufw.
    - [ ] Sub-task: Verify script execution on a test VM or dry-run.
- [x] Task: Configure UFW Firewall. [dbd21db]
    - [ ] Sub-task: Create `scripts/setup_firewall.sh` to allow 80, 443, 2222/tcp and enable UFW.
    - [ ] Sub-task: Verify UFW status and rules.
- [x] Task: Harden SSH Configuration. [7c23044]
    - [ ] Sub-task: Create `scripts/secure_ssh.sh` to backup `sshd_config`, change Port to 2222, disable `PermitRootLogin`, `PasswordAuthentication`.
    - [ ] Sub-task: **CRITICAL:** Manual verification step to ensure SSH access works on new port before closing session.
- [x] Task: Install & Configure Docker. [c159e43]
    - [ ] Sub-task: Create `scripts/install_docker.sh` to install Docker Engine & Compose plugin (official repo).
    - [ ] Sub-task: Configure non-root user access for Docker.
- [x] Task: Conductor - User Manual Verification 'Host Preparation & Hardening' (Protocol in workflow.md) [0f73051]

## Phase 2: Directory Structure & Network [checkpoint: 610385d]
- [x] Task: Create project directory structure. [ee71bda]
    - [x] Create `docker/`, `traefik/`, `scripts/` directories as per Guidelines.
- [x] Task: Define Docker Networks. [860c335]
    - [x] Draft `docker/docker-compose.yml` with `networks` section (e.g., `traefik-public`, `n8n-internal`).
- [x] Task: Conductor - User Manual Verification 'Directory Structure & Network' (Protocol in workflow.md) [610385d]

## Phase 3: Traefik Proxy Setup [checkpoint: 652be30]
- [x] Task: Configure Traefik Static Configuration. [8f7df07]
    - [x] Create `traefik/traefik.yml` (or command args in compose) for EntryPoints (80, 443) and ACME (Let's Encrypt).
- [x] Task: Define Traefik Service in Docker Compose. [9afe52b]
    - [x] Add `traefik` service to `docker/docker-compose.yml` with ports, volumes (docker.sock, letsencrypt), and network.
- [x] Task: Conductor - User Manual Verification 'Traefik Proxy Setup' (Protocol in workflow.md) [652be30]

## Phase 4: Database (PostgreSQL) [checkpoint: 719c209]
- [x] Task: Define PostgreSQL Service. [5231e40]
    - [x] Add `postgres` service to `docker/docker-compose.yml`.
    - [x] Configure environment variables for User/DB/Password (referencing `.env`).
    - [x] Define volume for persistence.
- [x] Task: Conductor - User Manual Verification 'Database (PostgreSQL)' (Protocol in workflow.md) [719c209]

## Phase 5: n8n Application Deployment [checkpoint: ab5595c]
- [x] Task: Define n8n Service. [2ab7de5]
    - [x] Add `n8n` service to `docker/docker-compose.yml`.
    - [x] Configure environment variables (`DB_TYPE`, `DB_POSTGRESDB_...`, `N8N_RUNNERS_ENABLED`, `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS`).
    - [x] Configure Traefik labels for n8n routing (Host(`n8n.yourdomain.com`), TLS).
- [x] Task: Create Environment Configuration. [e1eb6e8]
    - [x] Create `.env.example` with all required variables.
    - [x] Create actual `.env` (gitignored) for local deployment.
- [x] Task: Conductor - User Manual Verification 'n8n Application Deployment' (Protocol in workflow.md) [ab5595c]

## Phase 6: Final Verification & Documentation [checkpoint: b8b1b2c]
- [x] Task: Full Deployment Test. [manual]
    - [x] Run `docker compose up -d`.
    - [x] Verify logs for all containers.
    - [x] Verify external HTTPS access.
- [x] Task: Update Documentation. [cd6d633]
    - [x] Update `README.md` with deployment instructions.
- [x] Task: Conductor - User Manual Verification 'Final Verification & Documentation' (Protocol in workflow.md) [b8b1b2c]

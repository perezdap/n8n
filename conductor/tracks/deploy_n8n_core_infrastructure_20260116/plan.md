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

## Phase 2: Directory Structure & Network
- [x] Task: Create project directory structure. [ee71bda]
    - [ ] Sub-task: Create `docker/`, `traefik/`, `scripts/` directories as per Guidelines.
- [ ] Task: Define Docker Networks.
    - [ ] Sub-task: Draft `docker/docker-compose.yml` with `networks` section (e.g., `traefik-public`, `n8n-internal`).
- [ ] Task: Conductor - User Manual Verification 'Directory Structure & Network' (Protocol in workflow.md)

## Phase 3: Traefik Proxy Setup
- [ ] Task: Configure Traefik Static Configuration.
    - [ ] Sub-task: Create `traefik/traefik.yml` (or command args in compose) for EntryPoints (80, 443) and ACME (Let's Encrypt).
- [ ] Task: Define Traefik Service in Docker Compose.
    - [ ] Sub-task: Add `traefik` service to `docker/docker-compose.yml` with ports, volumes (docker.sock, letsencrypt), and network.
- [ ] Task: Conductor - User Manual Verification 'Traefik Proxy Setup' (Protocol in workflow.md)

## Phase 4: Database (PostgreSQL)
- [ ] Task: Define PostgreSQL Service.
    - [ ] Sub-task: Add `postgres` service to `docker/docker-compose.yml`.
    - [ ] Sub-task: Configure environment variables for User/DB/Password (referencing `.env`).
    - [ ] Sub-task: Define volume for persistence.
- [ ] Task: Conductor - User Manual Verification 'Database (PostgreSQL)' (Protocol in workflow.md)

## Phase 5: n8n Application Deployment
- [ ] Task: Define n8n Service.
    - [ ] Sub-task: Add `n8n` service to `docker/docker-compose.yml`.
    - [ ] Sub-task: Configure environment variables (`DB_TYPE`, `DB_POSTGRESDB_...`, `N8N_RUNNERS_ENABLED`, `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS`).
    - [ ] Sub-task: Configure Traefik labels for n8n routing (Host(`n8n.yourdomain.com`), TLS).
- [ ] Task: Create Environment Configuration.
    - [ ] Sub-task: Create `.env.example` with all required variables.
    - [ ] Sub-task: Create actual `.env` (gitignored) for local deployment.
- [ ] Task: Conductor - User Manual Verification 'n8n Application Deployment' (Protocol in workflow.md)

## Phase 6: Final Verification & Documentation
- [ ] Task: Full Deployment Test.
    - [ ] Sub-task: Run `docker compose up -d`.
    - [ ] Sub-task: Verify logs for all containers.
    - [ ] Sub-task: Verify external HTTPS access.
- [ ] Task: Update Documentation.
    - [ ] Sub-task: Update `README.md` with deployment instructions.
- [ ] Task: Conductor - User Manual Verification 'Final Verification & Documentation' (Protocol in workflow.md)

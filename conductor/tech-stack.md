# Tech Stack: Production n8n on Ubuntu 24.04

## Infrastructure
- **Cloud Provider:** OVH Cloud (Public Cloud Instance)
- **Operating System:** Ubuntu 24.04 LTS
- **Hardening:**
    - Firewall: UFW (Uncomplicated Firewall)
    - SSH: Custom port 2222
    - Process Management: Non-root execution for Docker services

## Containerization & Orchestration
- **Engine:** Docker (latest stable)
- **Orchestration:** Docker Compose V2
- **Network:** Isolated Docker bridge networks for internal service communication

## Core Services
- **n8n:**
    - Version: Pin to specific minor tags (e.g., `1.x`)
    - Mode: Queue Mode (`N8N_RUNNERS_ENABLED=true`)
    - Security: Settings file permission enforcement
- **Database:**
    - Engine: PostgreSQL 16
    - Persistence: Docker Volumes
- **Reverse Proxy:**
    - Engine: Traefik v3
    - SSL: Automatic via Let's Encrypt (ACME protocol)

## Automation & DevOps
- **Configuration:** Environment variables (`.env`)
- **Setup:** Automated Bash/Shell scripts
- **Version Control:** Git for infrastructure code and n8n workflow backups

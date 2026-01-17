# Initial Concept

"I want to deploy a production-ready n8n instance on an OVH Cloud Public Cloud instance (Ubuntu 24.04).

Tech Stack Preferences:

Containerization: Docker Compose V2.

Database: PostgreSQL 16 (for reliability over SQLite).

Reverse Proxy: Traefik v3 (with automatic SSL via Let's Encrypt).

OS Hardening: UFW firewall setup, SSH port change to 2222, and non-root Docker execution.

n8n Config: Enable N8N_RUNNERS_ENABLED for performance and N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS for security.

Product Goal: This server will host high-value AI-driven automation for Quality Engineering. It must be stable and easily backed up."

# Product Definition: Production-Ready n8n on OVH Cloud

## Product Vision
To deploy and maintain a high-stability, production-grade n8n instance on OVH Cloud Public Cloud (Ubuntu 24.04). This server will serve as the backbone for high-value AI-driven automations in Quality Engineering.

## Target Audience
- Quality Engineering Teams
- Automation Engineers

## Core Features & Infrastructure
- **n8n Instance:** Stable automation engine with `N8N_RUNNERS_ENABLED` for performance and strict file permissions for security.
- **Containerization:** Orchestrated via Docker Compose V2 with non-root execution.
- **Database:** PostgreSQL 16 for reliable, enterprise-grade data persistence.
- **Reverse Proxy:** Traefik v3 handling ingress traffic and automatic SSL termination via Let's Encrypt.
- **Security & Hardening:** 
    - UFW firewall configuration.
    - SSH port migration to 2222.
    - Standard outgoing internet access for AI integrations.
- **Maintenance Strategy:** Semi-automatic updates pinning to specific minor versions (e.g., `1.x`) to balance feature parity with stability.

## User Decisions Summary
- **Domain:** A custom domain will be provided for Traefik/SSL configuration.
- **Secrets:** Managed via `.env` files for practical security and simplicity.
- **Implementation:** Both automated setup scripts and detailed manual documentation will be provided.

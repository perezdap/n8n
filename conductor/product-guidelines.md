# Product Guidelines: n8n Production Deployment

## Documentation & Style
- **Commenting:** Use a verbose and educational commenting style in shell scripts and configuration files. Explain the rationale behind significant flags and settings to facilitate maintenance and knowledge transfer.
- **Documentation Tone:** Combine instructional tutorials (step-by-step with copy-paste blocks), technical reference (architecture and configuration), and concise checklists. This ensures accessibility for different user needs.

## Architecture & Organization
- **Repository Structure:** Adopt a modular and categorized organization.
    - `docker/`: Contains all Docker Compose and related service configurations.
    - `scripts/`: Holds setup, hardening, and maintenance scripts.
    - `traefik/`: Dedicated folder for proxy configurations and dynamic rules.
- **Naming Conventions:** Use semantic and descriptive names for all infrastructure components (e.g., `n8n-app`, `n8n-db`, `traefik-proxy`, `n8n-internal-network`).

## Standards & Protocols
- **Secrets Management:** Always use `.env.example` templates to guide the creation of local `.env` files. Ensure `.env` is ignored by version control.
- **Security Protocols:** 
    - Configuration files must prioritize strict file permissions (`N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS`).
    - Shell scripts should include basic error handling and validation checks.
- **Workflow Management:** Incorporate a strategy for syncing n8n workflows with a Git repository to ensure version control and easy recovery of automation logic.

## AI & Quality Engineering Specifics
- Ensure the infrastructure is optimized for long-running AI processes by monitoring resource usage (CPU/Memory) via Traefik or basic Linux tools.

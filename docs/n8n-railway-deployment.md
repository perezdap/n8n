# n8n Deployment on Railway

This document outlines the process for deploying n8n (workflow automation platform) on Railway.

## Overview

n8n is an open-source workflow automation tool. Self-hosting on Railway provides a cost-effective alternative to n8n Cloud.

## Railway Template

**Official Template**: https://railway.com/template/n8n

- **Template**: n8n (by Shinyduo)
- **Database**: PostgreSQL (required for persistence)
- **Category**: Automation

## Deployment Steps

### 1. Deploy from Template

1. Go to [Railway n8n Template](https://railway.com/template/n8n)
2. Click "Deploy Now"
3. Connect your GitHub account if prompted

### 2. Configure Environment Variables

Set the following variables in Railway:

| Variable | Value | Description |
|----------|-------|-------------|
| `PORT` | `5678` | n8n port (auto-set by Railway) |
| `N8N_ENCRYPTION_KEY` | `<random-string>` | Encryption key for credentials |
| `WEBHOOK_URL` | `https://<your-app>.up.railway.app/` | Public URL for webhooks |
| `DB_TYPE` | `postgresdb` | Database type |
| `DB_POSTGRESDB_HOST` | `${{ PostgreSQL.HOST }}` | PostgreSQL host |
| `DB_POSTGRESDB_PORT` | `${{ PostgreSQL.PORT }}` | PostgreSQL port |
| `DB_POSTGRESDB_USER` | `${{ PostgreSQL.USERNAME }}` | PostgreSQL user |
| `DB_POSTGRESDB_PASSWORD` | `${{ PostgreSQL.PASSWORD }}` | PostgreSQL password |
| `DB_POSTGRESDB_DATABASE` | `${{ PostgreSQL.DATABASE }}` | PostgreSQL database |
| `N8N_BASIC_AUTH_ACTIVE` | `true` | Enable basic auth |
| `N8N_BASIC_AUTH_USER` | `<your-username>` | Basic auth username |
| `N8N_BASIC_AUTH_PASSWORD` | `<your-password>` | Basic auth password |

### 3. Add Persistent Volume

1. In Railway dashboard, go to your n8n service
2. Click "Volumes" → "Add Volume"
3. Mount at `/home/node/.n8n` for workflow persistence

### 4. Optional: Enable Queue Mode (for scaling)

For high-volume deployments, enable worker mode:

```yaml
# Alternative: n8n Main + Worker template
# Template: https://railway.com/template/n8n-main-worker
```

## Cost Comparison

| Option | Monthly Cost | Executions | Notes |
|--------|--------------|------------|-------|
| **Railway Self-Hosted (Hobby)** | ~$5-15 | Unlimited | Pay for compute only |
| **Railway Self-Hosted (Pro)** | ~$20-40 | Unlimited | More resources |
| **n8n Cloud Starter** | €20/mo | 2.5K | Managed |
| **n8n Cloud Pro** | €50/mo | 10K | Managed |
| **n8n Cloud Business** | €667/mo | 40K | Managed |

## Environment Variables Reference

### Core Settings

```bash
N8N_ENCRYPTION_KEY=           # Random string for encrypting credentials
WEBHOOK_URL=https://...       # Public URL for receiving webhooks
N8N_HOST=                     # Custom host (optional)
N8N_PORT=5678                 # Port (optional)
N8N_PROTOCOL=https            # http or https
```

### Database

```bash
DB_TYPE=postgresdb            # Use PostgreSQL for persistence
DB_POSTGRESDB_HOST=           # PostgreSQL host
DB_POSTGRESDB_PORT=5432       # PostgreSQL port
DB_POSTGRESDB_USER=           # PostgreSQL user
DB_POSTGRESDB_PASSWORD=       # PostgreSQL password
DB_POSTGRESDB_DATABASE=       # PostgreSQL database name
```

### Execution Settings

```bash
EXECUTIONS_DATA_SAVE_ON_ERROR=all      # Save execution data on error
EXECUTIONS_DATA_SAVE_ON_SUCCESS=all    # Save execution data on success
EXECUTIONS_DATA_PRUNE=true             # Auto-cleanup old executions
EXECUTIONS_DATA_MAX_AGE=336            # Keep data for 336 hours (14 days)
```

### Security

```bash
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=your-secure-password
N8N_JWT_AUTH_ACTIVE=false
N8N_JWT_AUTH_HEADER=authorization
N8N_JWT_AUTH_VALUE_PREFIX=bearer
```

### Webhooks

```bash
N8N_EDITOR_BASE_URL=             # Editor base URL (defaults to WEBHOOK_URL)
N8N_ALLOW_IFRAME=false           # Disable iframe embedding
N8N_CONTENT_SECURITY_POLICY=     # Custom CSP headers (optional)
```

### External Storage (Optional)

```bash
EXECUTIONS_DATA_SAVE_ON_ERROR=all
EXECUTIONS_DATA_SAVE_ON_SUCCESS=all
N8N_ENCRYPTION_KEY=
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=
N8N_BASIC_AUTH_PASSWORD=
N8N_PROTOCOL=https
WEBHOOK_URL=
N8N_HOST=0.0.0.0
N8N_PORT=5678
N8N_EDITOR_BASE_URL=
```

## Maintenance

### Backup

Railway's managed PostgreSQL includes automatic backups. For additional backup:

1. Export workflows via n8n UI: Settings → Export → Download
2. Or use `pg_dump` for database backup

### Updates

1. Go to Railway dashboard
2. Select your n8n service
3. Click "Redeploy" to pull latest n8n Docker image
4. Check [n8n releases](https://github.com/n8n-io/n8n/releases) for breaking changes

## Troubleshooting

### Webhooks Not Working

- Verify `WEBHOOK_URL` is set correctly
- Check Railway domain is accessible publicly
- Ensure no firewall blocking incoming requests

### Database Connection Issues

- Verify all PostgreSQL environment variables are set
- Check PostgreSQL service is running
- Confirm credentials match

### High Memory Usage

- Enable execution data pruning
- Reduce `EXECUTIONS_DATA_MAX_AGE`
- Scale up Railway service resources

## Resources

- [n8n Documentation](https://docs.n8n.io/)
- [n8n GitHub](https://github.com/n8n-io/n8n)
- [Railway Documentation](https://docs.railway.app/)
- [n8n Community Forum](https://community.n8n.io/)

## Migration from OVH

If migrating from OVH:

1. Export all workflows from existing n8n instance
2. Deploy new instance on Railway using this guide
3. Import workflows via Settings → Import
4. Update webhook URLs in external services
5. Verify all credentials are working
6. Decommission old OVH server

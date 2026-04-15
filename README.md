# openclaw-railway

Railway deployment template for [OpenClaw](https://openclaw.ai) gateway.

## What this does

Runs `openclaw.mjs gateway` inside a Docker container on Railway. GitHub Actions builds the image, pushes to GHCR, and deploys to Railway on every push to `main`.

## Deploy

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template)

### Manual setup

**One-time Railway configuration (do this before the first deploy):**

1. Fork this repo
2. In Railway dashboard, create a new service and set source to **Docker Image** → `ghcr.io/<your-github-username>/openclaw-railway:latest`
3. If the GHCR package is private: Service Settings → Registry Credentials → add a GitHub PAT with `read:packages` scope (requires Railway Pro plan)
4. Copy the service ID from the Railway service URL (Settings → Service ID)
5. Add these secrets to your GitHub repo (Settings → Secrets → Actions):
   - `RAILWAY_TOKEN` — Railway project token (Railway project → Settings → Tokens)
   - `RAILWAY_SERVICE_ID` — the service ID from step 4
6. Push to `main` — the workflow builds, pushes to GHCR, then triggers Railway to pull and redeploy

## Required secrets

| Secret | Where to get it |
|---|---|
| `RAILWAY_TOKEN` | Railway project → Settings → Tokens |
| `RAILWAY_SERVICE_ID` | Railway service URL or Settings page |

## CI/CD

| Workflow | Trigger | What it does |
|---|---|---|
| `cd.yml` | Push to `main` | Builds image → pushes `ghcr.io/<owner>/openclaw-railway` → deploys to Railway |
| `docker-build.yml` | Pull request | Validates Dockerfile builds (no push) |

Dependabot keeps the base image (`ghcr.io/openclaw/openclaw`) updated daily.

## Configuration

Railway injects `$PORT`. The gateway binds `0.0.0.0` so Railway can route traffic. Crashes auto-restart after 3 seconds.

To change the OpenClaw version, update the `FROM` line in [`Dockerfile`](Dockerfile).

## GHCR visibility

Built images land in your repo's Packages. If Railway can't pull the image, set the package to public (repo → Packages → Change visibility) or add registry credentials in your Railway service settings.

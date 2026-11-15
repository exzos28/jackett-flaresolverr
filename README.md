# Jackett + FlareSolverr

Jackett and FlareSolverr in Docker: a Torznab search source, including indexers behind
Cloudflare.

## Run

```
docker compose up -d
```

Open http://localhost:9117 and, once:

1. **Add indexer** and sign in to yours.
2. Copy the **API Key** at the top of the page.

FlareSolverr is already set in Jackett: `init/flaresolverr.sh` writes its address and timeout
(`FLARESOLVERR_URL`, `FLARESOLVERR_TIMEOUT` in `compose.yml`) into Jackett's settings before each
start, so a change to them in Jackett's page lasts until the next restart.

The Torznab address for apps is
`http://<this computer's IP>:9117/api/v2.0/indexers/all/results/torznab/api`, with that key.

Settings and accounts stay in `./config` (not committed). Another port: `JACKETT_PORT=9118 docker compose up -d`.

## Stop, update

```
docker compose down
docker compose pull && docker compose up -d
```

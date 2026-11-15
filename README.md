# Jackett + FlareSolverr

Jackett and FlareSolverr in Docker: a Torznab search source, including indexers behind
Cloudflare.

## Run

```
./start.sh
```

It starts both containers, waits for Jackett and prints its addresses and API key:

```
Jackett:  http://localhost:9117
Torznab:  http://192.168.1.20:9117/api/v2.0/indexers/all/results/torznab/api
API key:  …
```

Open the Jackett address and, once:

1. **Add indexer** and sign in to yours.

FlareSolverr is already set in Jackett: `init/flaresolverr.sh` writes its address and timeout
(`FLARESOLVERR_URL`, `FLARESOLVERR_TIMEOUT` in `compose.yml`) into Jackett's settings before each
start, so a change to them in Jackett's page lasts until the next restart.

Settings and accounts stay in `./config` (not committed). Another port: `JACKETT_PORT=9118 ./start.sh`.

## Stop, update

```
docker compose down
docker compose pull && docker compose up -d
```

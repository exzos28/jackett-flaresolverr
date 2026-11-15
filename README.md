# Jackett + FlareSolverr

Jackett and FlareSolverr in Docker: a Torznab search source, including indexers behind
Cloudflare, at a short address (Caddy in front of Jackett).

## Run

```
./start.sh
```

It starts the containers, waits for Jackett and prints its addresses and API key:

```
Jackett:  http://localhost:9117
Torznab:  http://192.168.1.20:9117/torznab
API key:  …
```

`/torznab` is Jackett's all-indexers Torznab endpoint
(`/api/v2.0/indexers/all/results/torznab/api`, which works too); apps send the key with it.

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

# reel-jackett

Jackett and FlareSolverr in Docker: a search source (Torznab) for reel, including indexers
behind Cloudflare.

## Run

```
docker compose up -d
```

Open http://localhost:9117 and, once:

1. In **Jackett Configuration**, set **FlareSolverr API URL** to `http://flaresolverr:8191` and
   **FlareSolverr Max Timeout** to `120000`, then **Apply server settings**.
2. **Add indexer** and sign in to yours.
3. Copy the **API Key** at the top of the page.

In reel, the search source is
`http://<this computer's IP>:9117/api/v2.0/indexers/all/results/torznab/api` with that key.

Settings and accounts stay in `./config` (not committed). Another port: `JACKETT_PORT=9118 docker compose up -d`.

## Stop, update

```
docker compose down
docker compose pull && docker compose up -d
```

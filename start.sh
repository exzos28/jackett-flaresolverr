#!/bin/sh
# Starts Jackett and FlareSolverr, waits for Jackett, and prints the Torznab address and API key.
set -e
cd "$(dirname "$0")"
port=${JACKETT_PORT:-9117}
config=config/Jackett/ServerConfig.json

docker compose up -d

printf 'Waiting for Jackett'
i=0
until curl -s -o /dev/null -m 2 "http://localhost:$port/UI/Login" && grep -q '"APIKey": "[a-z0-9]' "$config" 2>/dev/null; do
  i=$((i + 1))
  [ "$i" -gt 90 ] && { echo; echo "Jackett did not start in 3 minutes: docker compose logs jackett"; exit 1; }
  printf '.'
  sleep 2
done
echo

key=$(sed -n 's/.*"APIKey": "\([a-z0-9]*\)".*/\1/p' "$config")
# This computer's address on the local network (macOS, then Linux).
ip=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null || hostname -I 2>/dev/null | awk '{print $1}')
[ -n "$ip" ] || ip="<this computer's IP>"

echo "Jackett:  http://localhost:$port"
echo "Torznab:  http://$ip:$port/api/v2.0/indexers/all/results/torznab/api"
echo "API key:  $key"

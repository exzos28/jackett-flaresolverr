#!/bin/sh
# Points Jackett at FlareSolverr before it starts: on the first run it writes the setting into a
# new ServerConfig.json (Jackett fills in the rest), afterwards it rewrites the two values.
f=/config/Jackett/ServerConfig.json
url=${FLARESOLVERR_URL:-http://flaresolverr:8191}
timeout=${FLARESOLVERR_TIMEOUT:-120000}
if [ -f "$f" ]; then
  sed -i -E "s#\"FlareSolverrUrl\": *\"[^\"]*\"#\"FlareSolverrUrl\": \"$url\"#; s#\"FlareSolverrMaxTimeout\": *[0-9]+#\"FlareSolverrMaxTimeout\": $timeout#" "$f"
else
  mkdir -p "$(dirname "$f")"
  printf '{\n  "FlareSolverrUrl": "%s",\n  "FlareSolverrMaxTimeout": %s\n}\n' "$url" "$timeout" > "$f"
  chown -R abc:abc /config/Jackett 2>/dev/null || true
fi

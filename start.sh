#!/bin/bash
set -e

# Railway injects $PORT (typically 8080). Bind the dashboard to it so Railway's
# HTTP proxy correctly forwards WebSocket connections.
# Fall back to 9119 only when $PORT is unset (e.g. local development).
DASHBOARD_PORT="${PORT:-9119}"

echo "Starting hermes dashboard with --tui on 0.0.0.0:${DASHBOARD_PORT}"

# Launch the dashboard with --tui in the background.
# We do this ourselves because the upstream entrypoint's auto-launch
# does not yet pass --tui (even with HERMES_DASHBOARD_TUI=1 set).
hermes dashboard \
    --tui \
    --host 0.0.0.0 \
    --port "${DASHBOARD_PORT}" \
    --no-open \
    --insecure \
    > >(sed 's/^/[dashboard] /') 2>&1 &

# Exec the gateway as the foreground process
exec hermes gateway run

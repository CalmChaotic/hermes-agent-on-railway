#!/bin/bash
set -e

# Launch the dashboard with --tui in the background.
# We do this ourselves because the upstream entrypoint's auto-launch
# does not yet pass --tui (even with HERMES_DASHBOARD_TUI=1 set).
echo "Starting hermes dashboard with --tui on 0.0.0.0:${HERMES_DASHBOARD_PORT:-9119}"
hermes dashboard \
    --tui \
    --host 0.0.0.0 \
    --port "${HERMES_DASHBOARD_PORT:-9119}" \
    --no-open \
    --insecure \
    > >(sed 's/^/[dashboard] /') 2>&1 &

# Exec the gateway as PID 1 (well, as the entrypoint's foreground child)
exec hermes gateway run

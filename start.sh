#!/bin/bash
set -e

# Pre-flight: warn if no LLM key is set
if [ -z "${OPENROUTER_API_KEY:-}" ]; then
  echo "WARNING: OPENROUTER_API_KEY is not set. The agent will not be able to call LLM providers." >&2
fi

# Start the gateway (handles Telegram, Slack, LLM routing) in the background
hermes gateway run &

# Run the dashboard as the foreground process so Railway can health-check it.
# --tui enables the embedded Chat tab (xterm.js + PTY-backed TUI in the browser).
# Railway injects $PORT; fall back to 9119 for local dev.
exec hermes dashboard --tui --insecure --host 0.0.0.0 --port "${PORT:-9119}"

FROM nousresearch/hermes-agent:latest

# Workaround for upstream issue #20500:
# /opt/hermes/ui-tui is root-owned but the dashboard runs as the hermes user,
# causing the Chat tab to fail with "Chat unavailable: 1".
# Fix by chowning to hermes user before the upstream entrypoint drops privileges.
USER root
RUN chown -R hermes:hermes /opt/hermes/ui-tui

# Tell the upstream entrypoint to:
#   1. Launch the web dashboard as a background side-process
#   2. Enable the embedded TUI Chat tab (xterm.js + PTY)
#   3. Bind dashboard to all interfaces (Railway needs this)
#   4. Listen on a fixed internal port — configure Railway's public domain
#      to target this port via the service's Networking settings.
ENV HERMES_DASHBOARD=1 \
    HERMES_DASHBOARD_TUI=1 \
    HERMES_DASHBOARD_HOST=0.0.0.0 \
    HERMES_DASHBOARD_PORT=9119

# Expose the dashboard port for Railway's port detection
EXPOSE 9119

# Run the gateway in the foreground. The upstream entrypoint will:
# - drop root privileges to the hermes user
# - launch the dashboard as a side process (because HERMES_DASHBOARD=1)
# - exec `hermes gateway run` as the foreground command
CMD ["gateway", "run"]

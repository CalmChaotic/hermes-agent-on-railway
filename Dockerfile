FROM nousresearch/hermes-agent:latest

# Workaround for upstream issue #20500: chown ui-tui to hermes user
USER root
RUN chown -R hermes:hermes /opt/hermes/ui-tui

# Note: We do NOT set HERMES_DASHBOARD=1 here. The upstream entrypoint's
# auto-launch ignores HERMES_DASHBOARD_TUI (docs are ahead of the released image),
# so we launch the dashboard ourselves with --tui in start.sh.

# Copy our wrapper that launches dashboard --tui in the background, then execs gateway
COPY start.sh /opt/hermes/railway-start.sh
RUN chmod +x /opt/hermes/railway-start.sh

# Pass our wrapper as the command. The upstream entrypoint will:
# - drop root privileges to the hermes user
# - exec our wrapper as the foreground command
# Our wrapper then launches the dashboard (with --tui) in background, and execs gateway.
CMD ["/opt/hermes/railway-start.sh"]

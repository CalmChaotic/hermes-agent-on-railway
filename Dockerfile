FROM nousresearch/hermes-agent:latest

# Workaround for upstream issue #20500: chown ui-tui to hermes user
USER root
RUN chown -R hermes:hermes /opt/hermes/ui-tui

# Workaround: the upstream entrypoint in nousresearch/hermes-agent:latest does
# NOT yet read HERMES_DASHBOARD_TUI, even though the docs say it does.
# So we DON'T set HERMES_DASHBOARD=1 — we launch the dashboard ourselves with --tui.
ENV HERMES_DASHBOARD_PORT=9119

EXPOSE 9119

# Copy our wrapper that launches dashboard --tui in the background, then execs gateway
COPY start.sh /opt/hermes/railway-start.sh
RUN chmod +x /opt/hermes/railway-start.sh

# Pass our wrapper as the command. The upstream entrypoint will:
# - drop root privileges to the hermes user
# - exec our wrapper as the foreground command
# Our wrapper then launches the dashboard with --tui in background, and execs gateway.
CMD ["/opt/hermes/railway-start.sh"]

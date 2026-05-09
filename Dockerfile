FROM nousresearch/hermes-agent:latest

# Workaround for upstream issue #20500:
# /opt/hermes/ui-tui is root-owned but the dashboard runs as the hermes user,
# causing the Chat tab to fail with "Chat unavailable: 1".
# Fix by chowning to hermes user before the upstream entrypoint drops privileges.
USER root
RUN chown -R hermes:hermes /opt/hermes/ui-tui

COPY start.sh /opt/hermes/railway-start.sh
RUN chmod +x /opt/hermes/railway-start.sh

# Preserve the upstream entrypoint (tini + /opt/hermes/docker/entrypoint.sh)
# which handles .env rendering, volume ownership, and privilege dropping.
# Our start.sh is passed as CMD — it runs the gateway + dashboard with --tui.
ENTRYPOINT ["/usr/bin/tini", "-g", "--", "/opt/hermes/docker/entrypoint.sh"]
CMD ["/opt/hermes/railway-start.sh"]

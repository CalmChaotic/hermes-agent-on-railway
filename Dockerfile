FROM nousresearch/hermes-agent:latest

COPY start.sh /opt/hermes/railway-start.sh
RUN chmod +x /opt/hermes/railway-start.sh

# Preserve the upstream entrypoint (tini + /opt/hermes/docker/entrypoint.sh)
# which handles .env rendering, volume ownership, and privilege dropping.
# Our start.sh is passed as CMD — it runs the gateway + dashboard.
ENTRYPOINT ["/usr/bin/tini", "-g", "--", "/opt/hermes/docker/entrypoint.sh"]
CMD ["/opt/hermes/railway-start.sh"]

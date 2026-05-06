# Troubleshooting

## Container crashes on startup

**Symptom:** Service restarts in a loop.

**Check logs** in Railway → Deployments → View logs. Common causes:

1. **Missing API key.** The gateway needs at least one LLM provider configured. Set `OPENROUTER_API_KEY` in your service variables.
2. **Volume not attached.** The upstream entrypoint expects `/opt/data` to exist. Add a volume mounted at `/opt/data` in service settings.

---

## Dashboard not accessible

**Symptom:** The Railway-generated URL returns nothing or a connection error.

1. **No public domain configured.** Go to Railway service → Settings → Networking → generate a domain.
2. **Service not ready yet.** The dashboard may take a moment to start after deploy.
3. **Check that Railway's `$PORT` is being used.** The start script binds to `$PORT` which Railway sets automatically.

---

## Telegram bot doesn't respond

1. **Check `TELEGRAM_BOT_TOKEN` is correct.** Regenerate via @BotFather if unsure.
2. **Check logs** for Telegram-related errors.
3. **Verify the gateway is running.** Logs should show the gateway starting up. If only the dashboard starts, check for errors in the gateway process.

---

## Slack bot doesn't respond

1. **Socket Mode must be enabled** in your Slack app settings.
2. **Check both tokens.** `SLACK_BOT_TOKEN` (`xoxb-…`) and `SLACK_APP_TOKEN` (`xapp-…`) are different — both are required.
3. **Check bot scopes.** Ensure `chat:write`, `app_mentions:read`, `im:history` are added.
4. **Check event subscriptions.** `message.im` and `app_mention` must be subscribed.
5. **Reinstall the app** to your workspace after changing scopes.

---

## Bot responds to everyone (unwanted)

Set `TELEGRAM_ALLOWED_USERS` and/or `SLACK_ALLOWED_USERS` to restrict access. See [Platform Setup](PLATFORMS.md) for how to find user IDs.

---

## Volume data lost after redeploy

Railway volumes persist across redeploys of the same service. If you **deleted and recreated** the service, the volume is gone. Export important data before destructive operations.

---

## Environment variables not taking effect

The upstream entrypoint renders environment variables into `/opt/data/.env` at boot. If you change a variable in Railway, you need to **redeploy** for the change to take effect.

# Template Variables Reference

Reference for configuring the Railway template in the template composer UI.
Railway does **not** read this file — it exists for the template maintainer.

## Service settings

| Setting | Value |
|---|---|
| **Service name** | `hermes-agent` |
| **Source** | GitHub repo: `CalmChaotic/railway-template-hermes-agent` |
| **Volume mount path** | `/opt/data` |
| **Public networking** | Enabled (Railway assigns `$PORT` automatically) |

## Variables to add in the composer

Railway injects these as environment variables. The upstream entrypoint
renders them into `/opt/data/.env` automatically — no custom scripting needed.

### Required

| Variable | Description |
|---|---|
| `OPENROUTER_API_KEY` | Your OpenRouter API key. Get one at https://openrouter.ai/keys |

### Optional — LLM providers

| Variable | Description |
|---|---|
| `ANTHROPIC_API_KEY` | Anthropic API key for Claude models. |
| `OPENAI_API_KEY` | OpenAI API key. |
| `NVIDIA_API_KEY` | NVIDIA API key. |
| `NOUS_API_KEY` | Nous Portal API key. |
| `HERMES_PORTAL_BASE_URL` | Custom base URL for Nous Portal (only needed with NOUS_API_KEY). |

### Optional — Telegram

| Variable | Description |
|---|---|
| `TELEGRAM_BOT_TOKEN` | Telegram bot token from @BotFather. Leave blank to disable Telegram. |
| `TELEGRAM_ALLOWED_USERS` | Comma-separated Telegram numeric user IDs. **SECURITY-CRITICAL:** if blank, anyone can talk to your bot. |

### Optional — Slack (Socket Mode)

| Variable | Description |
|---|---|
| `SLACK_BOT_TOKEN` | Slack Bot User OAuth Token (`xoxb-…`). Leave blank to disable Slack. |
| `SLACK_APP_TOKEN` | Slack App-Level Token (`xapp-…`) for Socket Mode. |
| `SLACK_ALLOWED_USERS` | Comma-separated Slack user IDs. |

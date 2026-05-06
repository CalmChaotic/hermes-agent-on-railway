# Hermes Agent — Railway Template

One-click deploy of [NousResearch Hermes Agent](https://github.com/NousResearch/hermes-agent) on Railway.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/template/TEMPLATE_ID?referralCode=REFERRAL)

> **Replace `TEMPLATE_ID` and `REFERRAL` above** after publishing your template.

---

## What you get

- **Hermes Agent** running from `nousresearch/hermes-agent:latest`
- Persistent volume at `/opt/data`
- Telegram and/or Slack messaging out of the box
- Web dashboard exposed via Railway networking

## Quick start

1. Click the **Deploy on Railway** button above.
2. Fill in at minimum `OPENROUTER_API_KEY`.
3. Optionally add Telegram or Slack tokens (see [Platform Setup](docs/PLATFORMS.md)).
4. Deploy. Done.

## Variables

### Required

| Variable | Description |
|---|---|
| `OPENROUTER_API_KEY` | Your OpenRouter API key. Get one at [openrouter.ai/keys](https://openrouter.ai/keys). |

### Optional — LLM providers

| Variable | Description |
|---|---|
| `ANTHROPIC_API_KEY` | Anthropic API key for Claude models. |
| `OPENAI_API_KEY` | OpenAI API key. |
| `NVIDIA_API_KEY` | NVIDIA API key. |
| `NOUS_API_KEY` | Nous Portal API key. |
| `HERMES_PORTAL_BASE_URL` | Custom base URL for Nous Portal. |

### Optional — Telegram

| Variable | Description |
|---|---|
| `TELEGRAM_BOT_TOKEN` | Bot token from [@BotFather](https://t.me/BotFather). |
| `TELEGRAM_ALLOWED_USERS` | Comma-separated numeric user IDs. **See security note below.** |

### Optional — Slack (Socket Mode)

| Variable | Description |
|---|---|
| `SLACK_BOT_TOKEN` | Bot User OAuth Token (`xoxb-…`). |
| `SLACK_APP_TOKEN` | App-Level Token (`xapp-…`) for Socket Mode. |
| `SLACK_ALLOWED_USERS` | Comma-separated Slack user IDs. |

## Security advisory

> **The Hermes dashboard has no built-in authentication.**
> Anyone with the URL can access it. Railway generates a public domain by default.
>
> **Mitigations:**
> - Remove the public domain from the Railway service settings if you do not need remote dashboard access.
> - Use Railway's [Private Networking](https://docs.railway.com/networking/private-networking) to restrict access.
>
> **For Telegram:** Always set `TELEGRAM_ALLOWED_USERS`. If left blank, **any Telegram user** can interact with your bot.

## How it works

This template is a thin wrapper around the official `nousresearch/hermes-agent:latest` Docker image. It preserves the upstream entrypoint (which handles `.env` rendering, volume ownership, and privilege dropping) and adds a start script that runs the gateway and dashboard together.

Railway injects your configured variables as environment variables. The upstream entrypoint writes them to `/opt/data/.env` automatically.

## Local development

```bash
cp .env.example .env
# Fill in your keys
docker compose up --build
```

## Docs

- [Deploy guide](docs/DEPLOY.md)
- [Telegram & Slack setup](docs/PLATFORMS.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)

## License

MIT

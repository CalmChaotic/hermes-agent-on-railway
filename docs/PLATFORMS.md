# Platform Setup

## Telegram

### 1. Create a bot

1. Open Telegram and message [@BotFather](https://t.me/BotFather).
2. Send `/newbot` and follow the prompts to name your bot.
3. BotFather gives you a **bot token** — copy it.

### 2. Get your user ID

1. Message [@userinfobot](https://t.me/userinfobot) on Telegram.
2. It replies with your numeric user ID.
3. If multiple users need access, collect each person's numeric ID.

### 3. Configure Railway variables

| Variable | Value |
|---|---|
| `TELEGRAM_BOT_TOKEN` | The token from BotFather |
| `TELEGRAM_ALLOWED_USERS` | Comma-separated numeric IDs, e.g. `123456789,987654321` |

> **Warning:** If `TELEGRAM_ALLOWED_USERS` is left empty, **anyone** on Telegram can talk to your bot.

### 4. Start chatting

Message your bot in Telegram. It should respond once the service is running.

---

## Slack (Socket Mode)

Socket Mode means your bot connects outbound — no public URL or webhook needed.

### 1. Create a Slack app

1. Go to [api.slack.com/apps](https://api.slack.com/apps) → **Create New App** → **From scratch**.
2. Name it (e.g. "Hermes Agent") and pick your workspace.

### 2. Enable Socket Mode

1. In the app settings, go to **Socket Mode** → toggle it **on**.
2. Generate an **App-Level Token** with the `connections:write` scope. Copy it (`xapp-…`).

### 3. Add bot scopes

1. Go to **OAuth & Permissions** → **Scopes** → **Bot Token Scopes**.
2. Add at minimum: `chat:write`, `app_mentions:read`, `im:history`, `im:read`, `im:write`.

### 4. Install to workspace

1. Go to **Install App** → **Install to Workspace**.
2. Authorize. Copy the **Bot User OAuth Token** (`xoxb-…`).

### 5. Enable events

1. Go to **Event Subscriptions** → toggle **on**.
2. Under **Subscribe to bot events**, add: `message.im`, `app_mention`.

### 6. Get user IDs for allow-list

1. In Slack, click a user's profile → **More** → **Copy member ID**.
2. Collect IDs for each user who should have access.

### 7. Configure Railway variables

| Variable | Value |
|---|---|
| `SLACK_BOT_TOKEN` | `xoxb-…` Bot User OAuth Token |
| `SLACK_APP_TOKEN` | `xapp-…` App-Level Token |
| `SLACK_ALLOWED_USERS` | Comma-separated member IDs, e.g. `U01ABC,U02DEF` |

### 8. Test

Mention `@Hermes Agent` in a channel the bot is in, or DM it directly.

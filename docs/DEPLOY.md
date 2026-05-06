# Deploy Guide

## Step 1 — Deploy as a regular Railway project

1. Go to [railway.com/new](https://railway.com/new) → **Deploy from GitHub repo**.
2. Select `CalmChaotic/railway-template-hermes-agent`.
3. Railway detects the Dockerfile automatically.
4. Go to **Variables** and add at minimum:
   - `OPENROUTER_API_KEY` → your key
   - Any optional vars you want (Telegram, Slack, additional LLM keys).
5. Go to **Settings → Volumes** → add a volume mounted at `/opt/data`.
6. Go to **Settings → Networking** → generate a public domain.
7. Deploy. Check logs for the gateway and dashboard starting up.

## Step 2 — Convert to a template

1. From your working project, click **Settings** (top-right of canvas).
2. Scroll to **Generate Template from Project**.
3. Click **Create Template** — opens the template composer pre-filled.
4. In the composer, verify all variables are present.
   See [TEMPLATE_VARIABLES.md](../TEMPLATE_VARIABLES.md) for the full list.
5. Click **Create Template**.

## Step 3 — Publish

1. Go to [railway.com/workspace/templates](https://railway.com/workspace/templates).
2. Find your template under **Personal**.
3. Click **Publish**. Fill in name and description.
4. Copy the template URL.

## Step 4 — Update the deploy badge

Replace the placeholder in `README.md`:

```
https://railway.com/template/TEMPLATE_ID?referralCode=REFERRAL
```

with your actual template URL.

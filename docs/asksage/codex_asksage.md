# Configure Codex CLI with an Ask Sage API key

Documentation owner: Repository maintainers. Reviewed: 2026-11-19.
Status: Documentation-checked; live Ask Sage authentication and model execution have not been tested.

For terminal use on macOS, Linux, or WSL. [Install Codex](https://docs.asksage.ai/integrations/codex/) before starting.

## 1. Request access

In [NAMS](https://nams.nasa.gov/nams/user?continue#), request **NASA Chat — 272250 (IT Asset, HQ)**. Once approved, continue below. Skip this step if you already have access.

## 2. Create the API key

1. Sign in to [NASA Chat](https://chat.asksage.ai.nasa.gov/dashboard).
2. Click **your name in the bottom-left corner → Settings → API Keys**.
3. Name the key, select **Passthrough** under **Access**, and click **+ Create Key**.
4. Save the key securely and note the API base URL shown in Settings. Do not use the dashboard URL as the API URL.

## 3. Load the key into your terminal

Start Bash with `bash`, then paste your key at the hidden prompt:

```bash
read -r -s -p 'Ask Sage API key: ' ASKSAGE_API_KEY
printf '\n'
export ASKSAGE_API_KEY
test -n "$ASKSAGE_API_KEY" && printf 'Key loaded.\n'
```

Repeat this in each new terminal. Never commit the key.

## 4. Configure Codex

Open the user configuration:

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}"
vi "${CODEX_HOME:-$HOME/.codex}/config.toml"
```

Merge these settings, replacing the host and model placeholders with values for your NASA account. Keep `model` and `model_provider` above any `[table]` headers; preserve unrelated settings.

```toml
model = "REPLACE_WITH_APPROVED_CODEX_MODEL_ID"
model_provider = "asksage"

[model_providers.asksage]
name = "Ask Sage"
base_url = "https://REPLACE_WITH_APPROVED_API_HOST/server/openai/v1"
wire_api = "responses"
env_key = "ASKSAGE_API_KEY"
requires_openai_auth = false
supports_websockets = false
```

Use the API host from Settings and keep `/server/openai/v1`. Ask your administrator for the supported Codex model ID.

For additional API authentication and endpoint details, see the [Ask Sage API endpoint documentation](https://docs.asksage.ai/api-documentation/api-endpoints/).

## 5. Start and verify

From a project directory in the same terminal:

```bash
codex
```

Confirm the session uses Ask Sage and your selected model. Ask: `Reply with only OK. Do not read files or run commands.`

## Tokens and references

NASA Chat starts at **500,000 tokens/month** and adds **500,000 at 90% usage**, within **15 minutes**, subject to the enterprise pool (replenished monthly). Designated organizational unit (OU) users should contact their unit point of contact. API allocation is unverified.

- [NASA Chat User Guide](https://developer.nasa.gov/pages/NasaChat/NasaChat-official-guide/) · [Service Desk](https://esd.nasa.gov/esdportal)
- [Ask Sage API keys](https://docs.asksage.ai/api-documentation/)
- [Codex configuration reference](https://learn.chatgpt.com/docs/config-file/config-reference)

NASA access details and token policy: contributor-supplied, 2026-11-19. NASA guide, request workflow, and API host not independently verified.

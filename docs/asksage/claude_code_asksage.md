# Configure Claude Code with an Ask Sage API key

Documentation owner: Repository maintainers. Reviewed: 2026-11-19.
Status: Documentation-checked; live Ask Sage authentication and model execution have not been tested.

For terminal use on macOS, Linux, or WSL. [Install Claude Code](https://docs.asksage.ai/integrations/claude-code/) before starting.

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
export ANTHROPIC_AUTH_TOKEN="$ASKSAGE_API_KEY"
unset ASKSAGE_API_KEY
unset ANTHROPIC_API_KEY
test -n "$ANTHROPIC_AUTH_TOKEN" && printf 'Key loaded.\n'
```

Repeat this in each new terminal. Never commit the key.

## 4. Configure Claude Code

Open the user settings:

```bash
mkdir -p "${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
vi "${CLAUDE_CONFIG_DIR:-$HOME/.claude}/settings.json"
```

Merge the following into existing JSON, preserving unrelated settings. Replace the host and model placeholders before saving:

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://REPLACE_WITH_APPROVED_API_HOST/server/anthropic",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "REPLACE_WITH_APPROVED_SONNET_ID",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "REPLACE_WITH_APPROVED_OPUS_ID",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "REPLACE_WITH_APPROVED_HAIKU_ID"
  },
  "model": "sonnet"
}
```

Use the API host from Settings and keep `/server/anthropic`. Ask your administrator for the supported Anthropic-compatible model IDs.

For additional API authentication and endpoint details, see the [Ask Sage API endpoint documentation](https://docs.asksage.ai/api-documentation/api-endpoints/).

## 5. Start and verify

From a project directory in the same terminal:

```bash
claude
```

Run `/status` to confirm the Ask Sage URL and `ANTHROPIC_AUTH_TOKEN`. Ask: `Reply with only OK. Do not read files or run commands.`

## Tokens and references

NASA Chat starts at **500,000 tokens/month** and adds **500,000 at 90% usage**, within **15 minutes**, subject to the enterprise pool (replenished monthly). Designated organizational unit (OU) users should contact their unit point of contact. API allocation is unverified.

- [NASA Chat User Guide](https://developer.nasa.gov/pages/NasaChat/NasaChat-official-guide/) · [Service Desk](https://esd.nasa.gov/esdportal)
- [Ask Sage API keys](https://docs.asksage.ai/api-documentation/)
- [Claude Code gateway configuration](https://code.claude.com/docs/en/llm-gateway-connect)

NASA access details and token policy: contributor-supplied, 2026-11-19. NASA guide, request workflow, and API host not independently verified.

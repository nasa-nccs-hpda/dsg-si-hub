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

1. Open a bash terminal:
**Windows users**: If you're using Command Prompt or PowerShell, 
start Bash by typing `bash` (requires Git Bash, Cygwin, or similar installed)

**macOS/Linux/WSL users**: Open your terminal (you're already in a Bash-compatible shell)
2. Run this command (will ask for your API key):

```bash
read -r -s -p 'Ask Sage API key: ' ASKSAGE_API_KEY
```

3. Paste your previously saved API key into the terminal, and hit enter.
4. Run these commands one-by-one:
```bash
export ANTHROPIC_AUTH_TOKEN="$ASKSAGE_API_KEY"
unset ASKSAGE_API_KEY
unset ANTHROPIC_API_KEY
test -n "$ANTHROPIC_AUTH_TOKEN" && printf 'Key loaded.\n'
```
6. You should see "Key loaded." printed.

Repeat this in each new terminal. Never commit the key.

## 4. Configure Claude Code

1. Open the user settings by running this command in your terminal:

```bash
mkdir -p "${CLAUDE_CONFIG_DIR:-$HOME/.claude}"; vi "${CLAUDE_CONFIG_DIR:-$HOME/.claude}/settings.json"
```

2. Enter insert mode by pressing "I" on your keyboard.
3. If you have an existing settings.json file, edit the section that looks like the section below. If you do not, paste the following snippet (using ctrl + v):

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.asksage.ai.nasa.gov/server/anthropic",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "claude-sonnet-4-5",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "claude-opus-4-5",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "claude-haiku-4-5"
  },
  "model": "sonnet"
}
```

4. (Optional) Replace model IDs: if you would like to change what models are used by default, change the default sonnet/opus/haiku models in the settings.json file. If you would like a list of approved Anthropic models, visit the [NASA Chat website](https://chat.asksage.ai.nasa.gov/), click your name in the bottom right, click "models", then scroll down until you see Anthropic models. To change the model in the .json, use the model name in all lowercase, with model name at the end with no "." character, and with dashes between words. So "Claude 4.6 Sonnet" should be written "claude-sonnet-4-6".
5. Save the file by hitting "esc", then typing ":wq" and hitting enter. This will exit the vim terminal.

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

NASA access details, API host, and token policy: contributor-supplied, 2026-11-19. API host taken from the supplied OpenCode configuration; live connectivity, NASA guide, and request workflow not independently verified.

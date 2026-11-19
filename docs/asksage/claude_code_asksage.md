# Configure Claude Code with an Ask Sage API key

Documentation owner: Repository maintainers. Reviewed: 2026-11-19.
Status: Documentation-checked; live Ask Sage authentication and model execution have not been tested.

For terminal use on macOS, Linux, or WSL. [Install Claude Code](https://docs.asksage.ai/integrations/claude-code/) before starting.

## 1. Request access

In [NAMS](https://nams.nasa.gov/nams/user?continue#), request **NASA Chat — 272250 (IT Asset, HQ)**. Once approved, continue below. Skip this step if you already have access.

## 2. Create the API key

1. Sign in to [NASA Chat](https://chat.asksage.ai.nasa.gov/dashboard)
2. Navigate to **your name (bottom-left corner) → Settings → API Keys**
3. Create a new key:
   - Enter a name for the key
   - Select **Passthrough** under **Access**
   - Click **+ Create Key**
4. Save the key securely
5. Note the **API base URL** shown in Settings (do not use the dashboard URL)

## 3. Load the key into your terminal

### Open a Bash terminal

- **Windows**: Open Command Prompt or PowerShell, then type `bash` and press Enter
  - Requires Git Bash, Cygwin, or WSL installed
- **macOS/Linux/WSL**: Open your default terminal (already Bash-compatible)

### Load your API key

1. Run this command to securely enter your API key:

```bash
read -r -s -p 'Ask Sage API key: ' ASKSAGE_API_KEY
```

2. Paste your saved API key and press Enter (the key will not be visible as you type)

3. Run these commands one at a time:

```bash
export ANTHROPIC_AUTH_TOKEN="$ASKSAGE_API_KEY"
unset ASKSAGE_API_KEY
unset ANTHROPIC_API_KEY
test -n "$ANTHROPIC_AUTH_TOKEN" && printf 'Key loaded.\n'
```

4. Confirm you see the message: `Key loaded.`

**Important**: Repeat these steps in each new terminal session. Never commit the key to version control.

## 4. Configure Claude Code settings

### Open the settings file

Run this command to create the config directory and open the settings file:

```bash
mkdir -p "${CLAUDE_CONFIG_DIR:-$HOME/.claude}"; vi "${CLAUDE_CONFIG_DIR:-$HOME/.claude}/settings.json"
```

### Edit the settings

1. Press `i` to enter insert mode in vim

2. Add or update the configuration:
   - **If the file is empty**: Paste the complete configuration below (Ctrl+V or Cmd+V)
   - **If the file has existing content**: Locate the `"env"` section and update it to match the values below

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

3. Save and exit:
   - Press `Esc` to exit insert mode
   - Type `:wq` and press Enter

### (Optional) Change default models

To use different Claude models:

1. Find available models at [NASA Chat](https://chat.asksage.ai.nasa.gov/):
   - Click your name (bottom-right) → **Models**
   - Scroll to the Anthropic section

2. Convert the model name to the correct format:
   - Use all lowercase
   - Replace spaces with hyphens
   - Remove periods
   - Example: `Claude 4.6 Sonnet` → `claude-sonnet-4-6`

3. Update the model IDs in `settings.json` above

For additional API authentication and endpoint details, see the [Ask Sage API endpoint documentation](https://docs.asksage.ai/api-documentation/api-endpoints/).

## 5. Start Claude Code and verify

### Launch Claude Code

Navigate to your project directory in the terminal and run:

```bash
claude
```

### Verify the configuration

1. Run the `/status` command to check:
   - The Ask Sage URL is set correctly
   - `ANTHROPIC_AUTH_TOKEN` is loaded

2. Test with a simple prompt:
   ```
   Reply with only OK. Do not read files or run commands.
   ```

If Claude responds with "OK", your configuration is complete.

## Token allocation and support

### Token limits

NASA Chat provides:
- **Initial allocation**: 500,000 tokens/month
- **Automatic refill**: 500,000 tokens added within 15 minutes at 90% usage
- Subject to enterprise pool availability (replenished monthly)
- API allocation details are unverified

**Note**: Designated organizational unit (OU) users should contact their unit point of contact for allocation questions.

### Support and documentation

- [NASA Chat User Guide](https://developer.nasa.gov/pages/NasaChat/NasaChat-official-guide/)
- [NASA Service Desk](https://esd.nasa.gov/esdportal)
- [Ask Sage API documentation](https://docs.asksage.ai/api-documentation/)
- [Claude Code gateway configuration](https://code.claude.com/docs/en/llm-gateway-connect)

---

*NASA access details, API host, and token policy: contributor-supplied, 2026-11-19. API host taken from the supplied OpenCode configuration; live connectivity, NASA guide, and request workflow not independently verified.*

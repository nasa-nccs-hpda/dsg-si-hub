# Configure Codex with an Ask Sage API key

Documentation owner: Repository maintainers. Reviewed: 2026-11-19.
Status: Documentation-checked; live Ask Sage authentication and model execution have not been tested.

For terminal use on macOS, Linux, or WSL. [Install Codex](https://docs.asksage.ai/integrations/codex/) before starting.

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
export ASKSAGE_API_KEY
test -n "$ASKSAGE_API_KEY" && printf 'Key loaded.\n'
```

4. Confirm you see the message: `Key loaded.`

**Important**: Repeat these steps in each new terminal session. Never commit the key to version control.

## 4. Configure Codex settings

### Open the settings file

Run this command to create the config directory and open the settings file:

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}"; vi "${CODEX_HOME:-$HOME/.codex}/config.toml"
```

### Edit the settings

1. Press `i` to enter insert mode in vim

2. Add or update the configuration:
   - **If the file is empty**: Paste the complete configuration below (Ctrl+V or Cmd+V)
   - **If the file has existing content**: Update the matching settings and tables below, preserving unrelated settings. Place top-level settings before any table headings; merge existing tables rather than duplicating them.

```toml
model = "gpt-5.6-sol"
model_provider = "asksage"
check_for_update_on_startup = false
web_search = "disabled"

[model_providers.asksage]
name = "Ask Sage"
base_url = "https://api.asksage.ai.nasa.gov/server/openai/v1"
wire_api = "responses"
env_key = "ASKSAGE_API_KEY"
requires_openai_auth = false
supports_websockets = false

[analytics]
enabled = false

[feedback]
enabled = false
```

Use the NASA API host noted in step 2 with the `/server/openai/v1` path. This adapts the environment-variable setup in the [Ask Sage Codex guide](https://docs.asksage.ai/integrations/codex/); NASA connectivity remains unverified. Keep the provider settings in your user configuration file.

3. Save and exit:
   - Press `Esc` to exit insert mode
   - Type `:wq` and press Enter

### (Optional) Change default models

To use a different model:

1. Find available models at [NASA Chat](https://chat.asksage.ai.nasa.gov/):
   - Click your name (bottom-right) → **Models**
   - Find the OpenAI model you want to use

2. Copy its exact API model ID; availability depends on your instance and account. The requested default is `gpt-5.6-sol`.

3. Update `model` in `config.toml` above

For additional API authentication and endpoint details, see the [Ask Sage API endpoint documentation](https://docs.asksage.ai/api-documentation/api-endpoints/).

#### Note for ITAR use

Please note that only the "gov" versions of models are approved for ITAR use. To specify one of those models, they should have the keyword "gov" appended, like so: "gpt-5.6-sol-gov". See [NASA Chat](https://chat.asksage.ai.nasa.gov/) models section for a list of gov models (you can search for "gov" in the top right of the models interface).

## 5. Start Codex and verify

### Launch Codex

Navigate to your project directory in the terminal where you loaded the key and run:

```bash
codex
```

### Verify the configuration

1. Run the `/status` command and confirm the selected model is `gpt-5.6-sol`. Check that `model_provider` is `asksage` and the NASA API URL is correct in `config.toml`. In the launching terminal, `test -n "$ASKSAGE_API_KEY" && printf 'Key loaded.\n'` confirms the key is loaded without displaying it.

2. Test with a simple prompt:
   ```
   Reply with only OK. Do not read files or run commands.
   ```

If Codex responds with "OK", your configuration is complete.

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
- [Codex gateway configuration](https://docs.asksage.ai/integrations/codex/)

---

*NASA access details, API host, and token policy: contributor-supplied, 2026-11-19. API host taken from the supplied OpenCode configuration; live connectivity, NASA guide, and request workflow not independently verified.*

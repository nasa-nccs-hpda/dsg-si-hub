# Configure Codex with an Ask Sage API key

Documentation owner: Repository maintainers. Reviewed: 2026-11-19.
Status: Documentation-checked; live Ask Sage authentication and model execution have not been tested.

For terminal use on macOS/Linux (Bash or Zsh), WSL (Bash), or Windows PowerShell (5.1 or later). [Install Codex](https://docs.asksage.ai/integrations/codex/) before starting.

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

Choose the commands for your shell and use that same terminal to launch Codex in step 5. On Windows, open PowerShell directly; WSL users should follow the macOS/Linux commands inside WSL.

### macOS/Linux/WSL — Bash or Zsh

1. Run this command to securely enter your API key. It works in both Bash and macOS's default Zsh:

```bash
printf 'Ask Sage API key: '; IFS= read -r -s ASKSAGE_API_KEY; printf '\n'
```

2. Paste your saved API key and press Enter (the key will not be visible as you type).

3. Run these commands:

```bash
export ASKSAGE_API_KEY
test -n "$ASKSAGE_API_KEY" && printf 'Key loaded.\n'
```

### Windows — PowerShell

1. Run this command to securely enter your API key:

```powershell
$askSageKey = Read-Host 'Ask Sage API key' -AsSecureString
```

2. Paste your saved API key and press Enter (PowerShell masks the input). **Note**: do NOT paste with `Ctrl` + `V`, this will only paste the character "V" and not your actual API key. Instead, right click and the key will paste.

3. Run these commands to make the key available to Codex in this terminal session:

```powershell
$env:ASKSAGE_API_KEY = [System.Net.NetworkCredential]::new('', $askSageKey).Password
$askSageKey.Dispose()
Remove-Variable askSageKey
if ($env:ASKSAGE_API_KEY) { Write-Output 'Key loaded.' }
```

Confirm you see `Key loaded.` before continuing. If it does not appear, repeat the key-entry steps for your shell.

**Important**: Repeat these steps in each new terminal session. The key is passed to Codex through the `ASKSAGE_API_KEY` environment variable; an export does not persist across terminal sessions or reboots. Never commit the key to version control.

## 4. Configure Codex settings

Codex reads the exported `ASKSAGE_API_KEY` through the `env_http_headers` setting below and sends its value as the `x-access-tokens` header. See the [Codex configuration reference](https://learn.chatgpt.com/docs/config-file/config-reference).

### Open the settings file

These commands use `CODEX_HOME` if set; otherwise, they use `.codex` in your home directory.

**macOS/Linux/WSL — Bash or Zsh:**

```bash
askSageConfigDir="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$askSageConfigDir"
vi "$askSageConfigDir/config.toml"
```

**Windows — PowerShell:**

```powershell
$askSageConfigDir = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }
New-Item -ItemType Directory -Path $askSageConfigDir -Force | Out-Null
notepad (Join-Path $askSageConfigDir 'config.toml')
```

If Notepad asks whether to create the file, choose **Yes**. You can also open the same file in your preferred text editor.

### Edit the settings

In Vi/Vim, press `i` to enter insert mode. In Notepad, edit the text directly.

- **If the file is empty**: Paste the complete configuration below.
- **If the file has existing content**: Update the matching settings and tables below, preserving unrelated settings. Place top-level settings before any table headings; merge existing tables rather than duplicating them.

Keep `"ASKSAGE_API_KEY"` as the environment variable's name in `env_http_headers`, without a `$` prefix. The actual key is entered in step 3; do not paste it into this configuration.

```toml
model = "gpt-5.4"
model_reasoning_effort = "high"
model_provider = "proxy"
web_search = "disabled"
[model_providers.proxy]
name = "NASA Chat"
base_url = "https://api.asksage.ai.nasa.gov/server/openai/v1"
env_http_headers = { "x-access-tokens" = "ASKSAGE_API_KEY" }
wire_api = "responses"
```

Use the NASA API host noted in step 2 with the `/server/openai/v1` path. This adapts the environment-variable setup in the [Ask Sage Codex guide](https://docs.asksage.ai/integrations/codex/); NASA connectivity remains unverified. Keep the provider settings in your user configuration file.

Save your changes:

- **Vi/Vim**: Press `Esc`, type `:wq`, and press Enter.
- **Notepad**: Press `Ctrl+S`, then close the editor. Keep the filename `config.toml` without an added `.txt` extension.

### (Optional) Change default models

To use a different model:

1. Find available models at [NASA Chat](https://chat.asksage.ai.nasa.gov/):
   - Click your name (bottom-right) → **Models**
   - Find the OpenAI model you want to use

2. Copy its exact API model ID; availability depends on your instance and account. The requested default is `gpt-5.4`.

3. Update `model` in `config.toml` above

For additional API authentication and endpoint details, see the [Ask Sage API endpoint documentation](https://docs.asksage.ai/api-documentation/api-endpoints/), and the [List of Codex AskSage NASA models](https://api.asksage.ai.nasa.gov/server/openai/v1/models)

#### Note for ITAR use

Please note that only the "gov" versions of models are approved for ITAR use. To specify one of those models, they should have the keyword "gov" appended, like so: "gpt-5.6-sol-gov". See [NASA Chat](https://chat.asksage.ai.nasa.gov/) models section for a list of gov models (you can search for "gov" in the top right of the models interface).

## 5. Start Codex and verify

### Launch Codex

Navigate to your project directory in the same terminal where you loaded the key. This command works in both Bash/Zsh and PowerShell:

```text
codex --no-daemon
```

`--no-daemon` bypasses Codex's shared background server so this session can inherit the key from the current terminal. This avoids reusing a server that may have started before the key was exported; a computer reboot is unnecessary. See the [Codex CLI reference](https://learn.chatgpt.com/docs/developer-commands?surface=cli).

### Verify the configuration

1. Run the `/status` command and confirm the selected model is `gpt-5.4` (or the model you chose). Check that `model_provider` is `proxy` and the NASA API URL is correct in `config.toml`. To confirm the key is loaded without displaying it, use the `Key loaded.` check for your shell in step 3 before launching Codex.

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
- [Zsh shell builtins (`read`)](https://zsh.sourceforge.io/Doc/Release/Shell-Builtin-Commands.html)
- [PowerShell masked input (`Read-Host`)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/read-host?view=powershell-5.1)
- [Codex gateway configuration](https://docs.asksage.ai/integrations/codex/)

---

*NASA access details, API host, and token policy: contributor-supplied, 2026-11-19. API host taken from the supplied OpenCode configuration; live connectivity, NASA guide, and request workflow not independently verified.*

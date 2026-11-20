# Configure Claude Code with an Ask Sage API key

Documentation owner: Repository maintainers. Reviewed: 2026-11-19.
Status: Documentation-checked; live Ask Sage authentication and model execution have not been tested.

For terminal use on macOS/Linux (Bash or Zsh), WSL (Bash), or Windows PowerShell (5.1 or later).  **This will likely require you to restart your terminal before continuing.**

## 1. Install Claude Code

1. Run the following command(s) based on your operating system:

```
# macOS, Linux, WSL
curl -fsSL https://claude.ai/install.sh | bash

# Windows PowerShell
irm https://claude.ai/install.ps1 | iex
```

2. If on Windows, you may receive a warning that Claude Code is not on your PATH environment variable. To fix it, paste and run this entire multiline command in PowerShell:

```powershell
& {
    $claudeBin = Join-Path $HOME '.local\bin'
    $userPath = [Environment]::GetEnvironmentVariable('Path', 'User')

    if ($claudeBin -notin ($userPath -split ';')) {
        $updatedPath = (@($userPath, $claudeBin) | Where-Object { $_ }) -join ';'
        [Environment]::SetEnvironmentVariable('Path', $updatedPath, 'User')
    }

    if ($claudeBin -notin ($env:Path -split ';')) {
        $env:Path += ";$claudeBin"
    }
}
```

3. Restart your terminal.

4. (Optional) See [AskSage Claude Code Page](https://docs.asksage.ai/integrations/claude-code/) for more info.

## 2. Request access

In [NAMS](https://nams.nasa.gov/nams/user?continue#), request **NASA Chat — 272250 (IT Asset, HQ)**. Once approved, continue below. Skip this step if you already have access.

## 3. Create the API key

1. Sign in to [NASA Chat](https://chat.asksage.ai.nasa.gov/dashboard)
2. Navigate to **your name (bottom-left corner) → Settings → API Keys**
3. Create a new key:
   - Enter a name for the key
   - Select **Passthrough** under **Access**
   - Click **+ Create Key**
4. Save the key securely
5. Note the **API base URL** shown in Settings (do not use the dashboard URL)

## 4. Load the key into your terminal

Choose the commands for your shell and use that same terminal to launch Claude Code in step 5. On Windows, open PowerShell directly; WSL users should follow the macOS/Linux commands inside WSL.

### macOS/Linux/WSL — Bash or Zsh

1. Run this command to securely enter your API key. It works in both Bash and macOS's default Zsh:

```bash
printf 'Ask Sage API key: '; IFS= read -r -s ASKSAGE_API_KEY; printf '\n'
```

2. Paste your saved API key and press Enter (the key will not be visible as you type).

3. Run these commands:

```bash
export ANTHROPIC_AUTH_TOKEN="$ASKSAGE_API_KEY"
unset ASKSAGE_API_KEY
unset ANTHROPIC_API_KEY
test -n "$ANTHROPIC_AUTH_TOKEN" && printf 'Key loaded.\n'
```

### Windows — PowerShell

1. Run this command to securely enter your API key:

```powershell
$askSageKey = Read-Host 'Ask Sage API key' -AsSecureString
```

2. Paste your saved API key and press Enter (PowerShell masks the input). **Note**: do NOT paste with `Ctrl` + `V`, this will only paste the character "V" and not your actual API key. Instead, right click and the key will paste.

3. Paste and run this entire multiline command to make the key available to Claude Code in this terminal session:

```powershell
$env:ANTHROPIC_AUTH_TOKEN = [System.Net.NetworkCredential]::new('', $askSageKey).Password
$askSageKey.Dispose()
Remove-Variable askSageKey
Remove-Item Env:ANTHROPIC_API_KEY -ErrorAction SilentlyContinue
if ($env:ANTHROPIC_AUTH_TOKEN) { Write-Output 'Key loaded.' }
```

The `. { ... }` block runs in the current PowerShell scope so it can remove the temporary `$askSageKey` variable. Repeat the key-entry steps before running this command again.

Confirm you see `Key loaded.` before continuing. If it does not appear, repeat the key-entry steps for your shell.

**Important**: Repeat these steps in each new terminal session. The key is passed to Claude Code through an environment variable; never commit it to version control.

## 5. Configure Claude Code settings

### Open the settings file

These commands use `CLAUDE_CONFIG_DIR` if set; otherwise, they use `.claude` in your home directory.

**macOS/Linux/WSL — Bash or Zsh:**

```bash
askSageConfigDir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
mkdir -p "$askSageConfigDir"
vi "$askSageConfigDir/settings.json"
```

**Windows — PowerShell:**

```powershell
$askSageConfigDir = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME '.claude' }
New-Item -ItemType Directory -Path $askSageConfigDir -Force | Out-Null
notepad (Join-Path $askSageConfigDir 'settings.json')
```

If Notepad asks whether to create the file, choose **Yes**. You can also open the same file in your preferred text editor.

### Edit the settings

In Vi/Vim, press `i` to enter insert mode. In Notepad, edit the text directly.

- **If the file is empty**: Paste the complete configuration below.
- **If the file has existing content**: Update the matching values in the `"env"` section and the top-level `"model"` setting, preserving unrelated settings. Merge into the existing JSON object rather than adding a second one.

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://api.asksage.ai.nasa.gov/server/anthropic",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "claude-sonnet-4-5",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "claude-opus-4-5",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "claude-haiku-4-5"
  },
  "model": "sonnet",
  "autoUpdatesChannel": "latest"
}
```

Save your changes:

- **Vi/Vim**: Press `Esc`, type `:wq`, and press Enter.
- **Notepad**: Press `Ctrl+S`, then close the editor. Keep the filename `settings.json` without an added `.txt` extension.

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

For additional API authentication and endpoint details, see the [Ask Sage API endpoint documentation](https://docs.asksage.ai/api-documentation/api-endpoints/), and the [List of Claude AskSage NASA models](https://api.asksage.ai.nasa.gov/server/anthropic/v1/models).

## 6. Start Claude Code and verify

### Launch Claude Code

Navigate to your project directory in the same terminal where you loaded the key. This command works in both Bash/Zsh and PowerShell:

```text
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
- [Zsh shell builtins (`read`)](https://zsh.sourceforge.io/Doc/Release/Shell-Builtin-Commands.html)
- [PowerShell masked input (`Read-Host`)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/read-host?view=powershell-5.1)
- [Claude Code gateway configuration](https://code.claude.com/docs/en/llm-gateway-connect)

---

*NASA access details, API host, and token policy: contributor-supplied, 2026-11-19. API host taken from the supplied OpenCode configuration; live connectivity, NASA guide, and request workflow not independently verified.*

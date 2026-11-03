# NMC AI Hub setup for Codex CLI and Claude Code

Use NASA Mission AI Hub (NMC AI Hub) through its LiteLLM proxy from a local workstation or NASA ADAPT/Discover. This is the complete setup guide for both clients: request access, create a key, install, configure the NASA gateway, and start a session. Complete the steps here for either or both clients. The supporting guides cover additional client-specific options:

- [Codex CLI advanced usage and troubleshooting](codex_nmc_ai_hub_adapt_discover.md)
- [Claude Code advanced usage and troubleshooting](claude_code_nmc_ai_hub_adapt_discover.md)

Documentation owner: Repository maintainers. Updated: 2026-11-03. The NAMS and key-creation steps come from user-supplied onboarding notes dated 2026-11-03; portal labels, budgets, and team availability have not been independently verified. Confirm changes with the [Mission AI Hub Teams channel](https://teams.microsoft.com/l/channel/19%3A6b44e9140031485790c07a9e6f65daaf%40thread.tacv2/Mission%20AI%20Hub?groupId=276ce13e-67d6-4fd0-82c9-9638d30b19ac&tenantId=7005d458-45be-48ae-8140-d43da96dd17b).

Setup steps: [Request access](#1-request-access-through-nams) → [Create a key](#2-create-a-virtual-key) → [Install](#3-install-a-client) → [Load the key](#4-load-the-key-and-configure-your-client) → [Configure Codex](#configure-codex-cli) or [Configure Claude](#configure-claude-code) → [Start work](#5-start-and-resume-work).

## 1. Request access through NAMS

1. Go to [NASA Access Management System (NAMS)](https://nams.nasa.gov/).
2. Under **New request**, in the middle of the screen, enter **Mission AI Hub** and press Enter.
3. Select the option with ID **272304**; the supplied instructions identify it as the first result.
4. Scroll to **account type**. Select **trial** for the smaller option, described in the notes as a **$25/month token budget**, or **Paid** for the larger option billed by token usage. Ask the Mission AI Hub team about current budgets and billing if needed.
5. In **data classification**, select Moderate or International Traffic in Arms Regulations (ITAR) data if your work requires it. Otherwise, uncheck **moderate**, which the supplied instructions describe as selected by default. Request the classification your work requires and use only data authorized for your approved service and environment.
6. Under project details, explain your personal use case for agentic development.
7. Click the blue **submit request** button in the bottom right. Once your requested team access is available, continue to key creation.

## 2. Create a virtual key

1. Open the [Mission AI Hub key-management portal](https://proxy.fast.luna.nasa.gov/ui/) and sign in with NASA Launchpad.
2. Click the large blue **create new key** button.
3. In the window that opens, ensure **owned by** is **you**.
4. Leave **organization** blank; it should fill automatically when you choose a team.
5. Click **team** and select the team made available by your NAMS request, such as **trial-moderate**. Confirm that team and organization are now filled in.
6. Enter a recognizable **key name**.
7. Leave the remaining fields blank, scroll down, and click the white **create key** button in the bottom right.
8. In the pop-up, click **copy virtual key**. Save it using an institutionally approved credential store, then load it as described in step 4. Keep the key out of repository files, shell history, shared notes, and screenshots.

If your requested team is missing, check with the Mission AI Hub team before creating a key for another team.

## 3. Install a client

### ADAPT/Discover Linux: install directly on `$NOBACKUP`

Perform setup separately on ADAPT and Discover if you use both filesystems. The supplied notes report a typical 10 GB home quota and a larger personal `$NOBACKUP` allocation; check your actual allocation and storage policy. The variable is **`$NOBACKUP`** (correcting `$NOBCACKUP` in the notes).

Create backing directories on `$NOBACKUP` **before** running the native installer. Home-directory symlinks retain the normal client paths:

| Home path | Contents placed on `$NOBACKUP` |
| --- | --- |
| `~/.codex` | Codex native packages, configuration, and sessions |
| `~/.claude` | Claude downloads, configuration, and sessions |
| `~/.local/share/claude` | Claude native versions |

The small executable launchers stay in `~/.local/bin`. Other client or operating-system caches may still use home storage. This procedure assumes default client directories; adapt an existing `CODEX_HOME`, `CLAUDE_CONFIG_DIR`, or XDG directory customization first.

Run this Bash block once per client, changing `nmc_client=codex` to `nmc_client=claude` for Claude Code. It requires `curl`, the native installer's dependencies, and executable, writable personal storage. Do not use `sudo`.

```bash
(
    set -eu
    : "${NOBACKUP:?Set NOBACKUP to your personal storage path first}"
    nmc_client=codex  # Change to claude to install Claude Code.
    nmc_root="$NOBACKUP/nmc-ai/$(uname -m)"
    umask 077

    nmc_link_dir() {
        if [ -d "$1" ] && [ -L "$2" ] && [ "$(readlink -f "$2")" = "$(readlink -f "$1")" ]; then
            return
        fi
        if [ -e "$2" ] || [ -L "$2" ]; then
            printf 'Existing path needs migration: %s\n' "$2" >&2
            return 1
        fi
        mkdir -p "$1" "$(dirname "$2")"
        ln -sT "$1" "$2"
    }

    # Preserve an existing launcher, including one managed by another installer.
    if [ -e "$HOME/.local/bin/$nmc_client" ] || [ -L "$HOME/.local/bin/$nmc_client" ]; then
        printf 'Existing launcher needs review: %s\n' "$HOME/.local/bin/$nmc_client" >&2
        exit 1
    fi
    mkdir -p "$HOME/.local/bin"
    export PATH="$HOME/.local/bin:$PATH"
    nmc_installer=$(mktemp /tmp/nmc-ai-install.XXXXXX)
    trap 'rm -f "$nmc_installer"' EXIT

    case "$nmc_client" in
        codex)
            nmc_link_dir "$nmc_root/codex" "$HOME/.codex"
            curl -fsSL https://chatgpt.com/codex/install.sh -o "$nmc_installer"
            TMPDIR=/tmp CODEX_HOME="$HOME/.codex" \
                CODEX_INSTALL_DIR="$HOME/.local/bin" sh "$nmc_installer"
            ;;
        claude)
            nmc_link_dir "$nmc_root/claude-config" "$HOME/.claude"
            nmc_link_dir "$nmc_root/claude-install" "$HOME/.local/share/claude"
            curl -fsSL https://claude.ai/install.sh -o "$nmc_installer"
            TMPDIR=/tmp bash "$nmc_installer"
            ;;
        *) printf 'Choose codex or claude\n' >&2; exit 1 ;;
    esac
)
```

Existing home directories, launchers, or links to another location cause this fresh-install procedure to stop. For an existing installation, close its sessions, preserve configuration/history, and migrate it deliberately before retrying. Do not overwrite existing files or move them out from under running sessions.

Add this line once to `~/.bashrc`, and run it in the current shell:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Check the installed client with `codex --version` or `claude --version`. Back up configuration and session history according to site policy; a symlink does not make `$NOBACKUP` backed-up storage.

The native paths and Codex installer variables were checked against the [Codex installer](https://chatgpt.com/codex/install.sh) and [Claude installer](https://claude.ai/install.sh) on 2026-11-03. Installation has not been tested on NASA filesystems. See also [Codex installation](https://learn.chatgpt.com/docs/codex/cli) and [Claude installation](https://code.claude.com/docs/en/setup).

### Login-node amd64 versus compute-node arm64

Run `uname -m` **on the node where the CLI will execute**:

| Output | Native binary architecture |
| --- | --- |
| `x86_64` | amd64 / x64 |
| `aarch64` or `arm64` | arm64 |

Both native installers detect the installation machine's architecture. An amd64 login-node installation will therefore not run natively on an arm64 compute node. Install on an authorized node of the target architecture with access to the installers, or arrange deployment of the matching vendor build with site support. Also confirm operating-system compatibility, executable storage mounts, and access to the NASA proxy from the execution node.

The block above separates backing directories by architecture, but its home links and launchers select **one architecture per shared home**. It refuses to replace links when run on another architecture. For both architectures under the same home, use separate installation prefixes and architecture-selecting launchers with site support; changing a shared symlink can break sessions on other nodes. Run `command -v codex` / `command -v claude` and a version check on each execution node.

### Local macOS and Windows

Local clients use the same NASA key and client configuration, without the `$NOBACKUP` layout.

For Codex on macOS:

```bash
curl -fsSL https://chatgpt.com/codex/install.sh | sh
```

For Codex on Windows, install [Node.js](https://nodejs.org/en/download), then run in PowerShell:

```powershell
npm install -g @openai/codex
```

For Claude Code on macOS:

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

For Claude Code on Windows, run in PowerShell:

```powershell
irm https://claude.ai/install.ps1 | iex
```

The Claude commands come from [Anthropic's installation guide](https://code.claude.com/docs/en/setup). Open a new terminal after installation. Verify the client you installed with `codex --version` or `claude --version`, then continue below using your local project paths.

## 4. Load the key and configure your client

Load the virtual key as `NASA_LITELLM_API_KEY` using approved credential tooling. For a temporary Bash session, this prompt avoids putting the literal key in shell history or terminal output:

```bash
read -r -s -p "Mission AI Hub virtual key: " NASA_LITELLM_API_KEY
printf '\n'
export NASA_LITELLM_API_KEY
test -n "$NASA_LITELLM_API_KEY" && echo "API key configured"
```

For a temporary Windows PowerShell session:

```powershell
$nmcCredential = Get-Credential -UserName 'Mission AI Hub' -Message 'Enter the virtual key in the password field'
$env:NASA_LITELLM_API_KEY = $nmcCredential.GetNetworkCredential().Password
Remove-Variable nmcCredential
```

Repeat key loading in new shells unless approved credential tooling handles it. For persistence, use approved secret tooling; a plaintext export in a startup file is appropriate only if local credential-handling policy permits it. Environment variables are available to child processes; do not print them in diagnostics.

Both clients can use the same virtual key when the team grants access to their models. Complete the subsection for each client you installed. Merge examples with existing settings rather than replacing the files wholesale. The endpoint, model aliases, and Claude compatibility flags are retained from the previous NASA configuration examples; current gateway access and model availability have not been independently tested.

### Configure Codex CLI

Edit your user-level configuration. On Linux/macOS:

```bash
mkdir -p ~/.codex
vi ~/.codex/config.toml
```

On Windows, open `%USERPROFILE%\.codex\config.toml` in your editor, creating the directory/file if needed. Merge the following with existing settings:

```toml
model_provider = "nasa"
model = "gpt-6-astra"

[model_providers.nasa]
name = "NASA LiteLLM"
base_url = "https://proxy.fast.luna.nasa.gov"
env_key = "NASA_LITELLM_API_KEY"
wire_api = "responses"
```

`env_key` reads the virtual key from your environment; do not put the key in TOML. This custom provider uses the Responses API through the NASA proxy. Confirm the model alias and access with the Mission AI Hub team if a request fails.

Check that the key and executable are available in the launching shell:

```bash
test -n "$NASA_LITELLM_API_KEY" && echo "API key configured"
codex --version
```

On Windows PowerShell, use `if ($env:NASA_LITELLM_API_KEY) { "API key configured" }` for the key check. Continue to step 5 to test a request through the NASA gateway; this custom provider does not require a separate ChatGPT login.

### Configure Claude Code

Create your user-level settings file on Linux/macOS (the Linux installation above may already have linked this directory to `$NOBACKUP`):

```bash
mkdir -p ~/.claude
chmod 700 ~/.claude
vi ~/.claude/settings.json
```

On Windows, edit `%USERPROFILE%\.claude\settings.json`, creating the directory/file if needed. Merge the following with existing settings. These model aliases and compatibility flags are retained from the existing site-provided NASA Mission AI Hub configuration; confirm their current applicability with the Hub team:

```json
{
  "env": {
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "claude-haiku-4.5",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "claude-sonnet-5-thinking",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "claude-5-opus-thinking",
    "DISABLE_TELEMETRY": "1",
    "ANTHROPIC_BASE_URL": "https://proxy.fast.luna.nasa.gov/",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS": "1",
    "CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING": "1"
  },
  "model": "sonnet",
  "theme": "auto"
}
```

Map the key loaded above to Claude's bearer-token variable in the shell that launches Claude Code:

```bash
export ANTHROPIC_AUTH_TOKEN="$NASA_LITELLM_API_KEY"
unset ANTHROPIC_API_KEY
```

On Windows PowerShell:

```powershell
$env:ANTHROPIC_AUTH_TOKEN = $env:NASA_LITELLM_API_KEY
Remove-Item Env:ANTHROPIC_API_KEY -ErrorAction SilentlyContinue
```

For persistence, have your approved credential-loading process set this mapping after loading `NASA_LITELLM_API_KEY`. Keep the token out of the JSON file. The base URL is the proxy root; do not append `/v1/messages`. The `"model": "sonnet"` setting selects the configured Sonnet alias. Additional model-selection and private-file options are in the [Claude supplement](claude_code_nmc_ai_hub_adapt_discover.md).

Check the configuration on Linux/macOS:

```bash
python3 -m json.tool ~/.claude/settings.json >/dev/null && echo "Valid JSON"
test -n "$ANTHROPIC_AUTH_TOKEN" && echo "Token configured"
claude --version
```

On Windows PowerShell:

```powershell
Get-Content "$env:USERPROFILE\.claude\settings.json" -Raw | ConvertFrom-Json | Out-Null
if ($env:ANTHROPIC_AUTH_TOKEN) { "Token configured" }
claude --version
```

## 5. Start and resume work

Open your project with `cd /path/to/project`, then start the configured client:

| Action | Codex CLI | Claude Code |
| --- | --- | --- |
| Interactive development | `codex -a on-request -s workspace-write` | `claude --permission-mode acceptEdits` |
| Review/planning | `codex -a on-request -s read-only` | `claude --permission-mode plan` |
| Resume latest | `codex resume --last` | `claude --continue` |
| Choose a prior session | `codex resume` | `claude --resume` |

For the first request, ask: **Summarize this repository's purpose from its README without changing any files.** Check authentication, model selection, and file-reading tools. A version check or valid configuration alone does not establish gateway compatibility. Allow the client to prompt for project trust when opening a repository. See the client supplements before choosing autonomous operation or changing sandbox settings.

The supplied usage notes report a first prompt taking **two minutes or more**, followed by normal response times. This is a user observation; its cause and frequency have not been measured. Allow for that initial delay. If it persists or produces errors, record the client version, node architecture, model, elapsed time, and redacted error, and contact the Mission AI Hub team.

## Troubleshooting and updates

- **Command not found:** Verify `~/.local/bin` is in `PATH`. Use `type -a codex` or `type -a claude` to find an older installation taking precedence.
- **Permission errors:** Check symlink targets, ownership, free space, and executable mount permissions. `TMPDIR=/tmp` changes temporary storage; it does not fix an incompatible binary or a `noexec` mount.
- **Exec format error:** Compare `uname -m` with `file "$(readlink -f "$HOME/.local/bin/codex")"` (substitute `claude` as needed).
- **Authentication/model/tool errors:** Verify key loading and the client configuration in step 4, then confirm the selected alias with the Mission AI Hub team. The client supplements cover protocol-specific troubleshooting.
- **Updates:** Close sessions using that installation across all nodes first. Rerun the Codex installer with the same linked directories; use `claude update` for Claude. Claude native installs auto-update by default. Follow [Anthropic's network-storage guidance](https://code.claude.com/docs/en/setup#install-on-network-storage) before concurrent use across nodes, so updates preserve executables still in use elsewhere.

## Additional client options and sources

The setup above is sufficient to install and configure either client. For permissions, autonomous operation, model selection, and detailed troubleshooting, use the [Codex supplement](codex_nmc_ai_hub_adapt_discover.md) or [Claude supplement](claude_code_nmc_ai_hub_adapt_discover.md).

Client configuration and command syntax were checked on 2026-11-03 against the [OpenAI configuration reference](https://learn.chatgpt.com/docs/config-file/config-reference), [OpenAI CLI reference](https://learn.chatgpt.com/docs/developer-commands?surface=cli), local `codex --help` (0.166.0), [Claude gateway documentation](https://code.claude.com/docs/en/llm-gateway-connect), and [LiteLLM's Claude Code guide](https://docs.litellm.ai/docs/proxy/client_setup/claude_code). NASA authentication, sandbox execution, and end-to-end tool compatibility were not tested.

# NMC AI Hub setup for Codex CLI and Claude Code

Codex CLI and Claude Code are assistants you use from a terminal to explain code, work with files, and help make changes. This guide connects them to NASA Mission AI Hub (NMC AI Hub) on your own computer or on the ADAPT/Discover NASA filesystems. Follow the steps for either tool or both. The supporting guides cover additional options/tips and tricks:

- [Codex CLI advanced usage and troubleshooting](codex_nmc_si_hub.md)
- [Claude Code advanced usage and troubleshooting](claude_code_nmc_si_hub.md)

## 1. Request access through NAMS

1. Go to [NASA Access Management System (NAMS)](https://nams.nasa.gov/).

2. Under **New request**, in the middle of the screen, enter **Mission AI Hub** and press Enter.

3. Select the option with ID **272304**; this should be the first result.

4. Scroll to **account type**, and select one of the options below.

- Select **trial** for the smaller option, which gives you a **$25/month token budget**.
- Select **Paid** for the larger option billed by token usage.
- Ask the Mission AI Hub team about current budgets and billing if needed. Visit [Mission AI Hub Teams Channel](https://teams.microsoft.com/l/channel/19%3A6b44e9140031485790c07a9e6f65daaf%40thread.tacv2/Mission%20AI%20Hub?groupId=276ce13e-67d6-4fd0-82c9-9638d30b19ac&tenantId=7005d458-45be-48ae-8140-d43da96dd17b) for more.

5. In **data classification**, select Moderate or ITAR data if your work requires it. Otherwise, uncheck **moderate**, which is selected by default. Request the classification your work requires and use only data authorized for your approved service and environment.

6. Under project details, briefly describe how you plan to use these assistants in your work.

7. Click the blue **submit request** button in the bottom right. Once your requested team access is available, continue to key creation.

## 2. Create a virtual key (after NAMS request has been approved)

**Note: this will not work unless the Mission AI Hub request has been approved!**

1. Open the [Mission AI Hub key-management portal](https://proxy.fast.luna.nasa.gov/ui/) and sign in with NASA Launchpad.

2. Click the large blue **create new key** button.

3. In the window that opens, ensure **owned by** is **you**.

4. Leave **organization** blank; it should fill automatically when you choose a team.

5. Click **team** and select the team made available by your NAMS request, such as **trial-moderate**. Confirm that team and organization are now filled in.

6. Enter a recognizable **key name**; this can be anything you like.

7. Leave the remaining fields blank, scroll down, and click the white **create key** button in the bottom right.

8. In the pop-up, click **copy virtual key**. Save it using an institutionally approved credential store, then load it as described in step 4. Keep the key out of repository files, shell history, shared notes, and screenshots.

If your requested team is missing, check with the Mission AI Hub team before creating a key for another team. [Mission AI Hub Teams Channel](https://teams.microsoft.com/l/channel/19%3A6b44e9140031485790c07a9e6f65daaf%40thread.tacv2/Mission%20AI%20Hub?groupId=276ce13e-67d6-4fd0-82c9-9638d30b19ac&tenantId=7005d458-45be-48ae-8140-d43da96dd17b)

## 3. Install Codex/Claude client

Choose the section for the computer where you will run Codex or Claude Code.

### ADAPT/Discover Linux

#### a. Run the installer on a login node

1. Connect to an ADAPT or Discover login node and open a Bash terminal. Run setup separately on each system if you use both.

2. Download [install-nmc-clients.sh](../../install-nmc-clients.sh) from this repository and put it on the login node. If you already have this repository there, the script is in the repository root. In the terminal, change to the directory containing the script.

3. Run **one** of these commands:

   | What to install | Command |
   | --- | --- |
   | Both tools | `bash install-nmc-clients.sh` |
   | Codex only | `bash install-nmc-clients.sh --codex` |
   | Claude Code only | `bash install-nmc-clients.sh --claude` |

   You can also pass `--codex --claude` to install both. Use `--help` to see the options. The script prints progress as it prepares storage, downloads, and installs each tool. Wait for it to finish.

   `$NOBACKUP` is already configured for your user account; you do not need to set it. The script places the programs, settings, and session history there to save home-directory space. Links in your home directory let the tools find those files. Small launchers stay in `~/.local/bin`; some other caches may still use home storage. Do not use `sudo`.

4. Run this line so the terminal can find the installed tools. Also add it once to your `~/.bashrc` file so future terminals can find them:

   ```bash
   export PATH="$HOME/.local/bin:$PATH"
   ```

**Existing installations:** The script can update installations it created. If it finds an existing directory or launcher it does not manage, it stops and identifies the path. Close any running sessions and ask site support to help preserve your settings and history before migrating it. Back up those files according to site policy; `$NOBACKUP` is not backed-up storage.

#### b. Check the version

Run the command for each tool you installed:

```bash
codex --version
claude --version
```

Each should print a version number. Then continue to step 4.

#### Note for ADAPT Grace node usage

Grace nodes use a different processor (arm64) from the login nodes. To run there, close your Codex/Claude sessions and rerun the installer **on the Grace node** (substeps **a** and **b**), then check the versions there. Your settings and history are kept. Rerun on a login node to switch back; this installation uses one processor type at a time.

### Local Windows

1. Open **PowerShell** from the Start menu.

2. **For Codex:** Install the **LTS (Long Term Support)** version of [Node.js](https://nodejs.org/en/download) using its Windows installer. Node.js includes `npm`, the command used to install Codex. Close and reopen PowerShell, then check:

   ```powershell
   node --version
   npm --version
   ```

   Both commands should print version numbers. Skip this step if you are installing only Claude Code; its installer does not need Node.js.

3. Run the command for each tool you want:

   **Codex:**

   ```powershell
   npm install -g @openai/codex
   ```

   **Claude Code:**

   ```powershell
   irm https://claude.ai/install.ps1 | iex
   ```

4. Close and reopen PowerShell. Check each tool you installed:

   ```powershell
   codex --version
   claude --version
   ```

   Each should print a version number. If PowerShell reports that scripts are disabled for an npm command, use `npm.cmd` or `codex.cmd` in place of `npm` or `codex`. Continue to step 4 of this guide.

### Local macOS

1. Open **Terminal** from Applications → Utilities. These installers do not need Node.js.

2. Run the command for each tool you want:

   **Codex:**

   ```bash
   curl -fsSL https://chatgpt.com/codex/install.sh | sh
   ```

   **Claude Code:**

   ```bash
   curl -fsSL https://claude.ai/install.sh | bash
   ```

3. Close and reopen Terminal. Check each tool you installed:

   ```bash
   codex --version
   claude --version
   ```

   Each should print a version number. Continue to step 4.

## 4. Load your key

Your virtual key is like a password: it lets the tools use your Mission AI Hub access and budget. Loading it here makes it available to programs started from this terminal, without saving it in your project files.

1. Find the virtual key you saved in step 2. Keep it out of shared notes, screenshots, and code.

2. In the terminal where you will run Codex or Claude Code, copy and run the block for your system.

   **ADAPT/Discover or macOS:**

   ```bash
   printf 'Mission AI Hub virtual key: '
   read -r -s NASA_LITELLM_API_KEY
   printf '\n'
   export NASA_LITELLM_API_KEY
   export ANTHROPIC_AUTH_TOKEN="$NASA_LITELLM_API_KEY"
   unset ANTHROPIC_API_KEY
   ```

   When prompted, paste the key and press Enter. It will not appear on screen as you paste.

   **Windows PowerShell:**

   ```powershell
   $nmcCredential = Get-Credential -UserName 'Mission AI Hub' -Message 'Paste your virtual key in the password field'
   $env:NASA_LITELLM_API_KEY = $nmcCredential.GetNetworkCredential().Password
   $env:ANTHROPIC_AUTH_TOKEN = $env:NASA_LITELLM_API_KEY
   Remove-Item Env:ANTHROPIC_API_KEY -ErrorAction SilentlyContinue
   Remove-Variable nmcCredential
   ```

   Paste the key in the **password** field and confirm.

3. Check that the key was entered. This prints a confirmation without revealing it.

   **ADAPT/Discover or macOS:**

   ```bash
   if [ -n "$NASA_LITELLM_API_KEY" ]; then echo "Key loaded"; else echo "No key entered; repeat step 4"; fi
   ```

   **Windows PowerShell:**

   ```powershell
   if ($env:NASA_LITELLM_API_KEY) { "Key loaded" } else { "No key entered; repeat step 4" }
   ```

4. Keep this terminal open and continue below. **Repeat this step whenever you open a new terminal to use the tools.** If your institution provides approved software that loads credentials for you, you can use that instead. This check confirms that a key was entered; your first request in step 6 will check whether it works.

## 5. Configure Claude/Codex tool(s) to use NMC AI Hub

This one-time setup tells agents to send requests through Mission AI Hub. Complete the subsection for each tool you installed (Claude/Codex), on each computer or system where you use it. The same virtual key can serve both tools when your Hub team grants access to their models.

If a settings file already has content, keep it and merge the settings below. Ask for help on the [Mission AI Hub Teams Channel](https://teams.microsoft.com/l/channel/19%3A6b44e9140031485790c07a9e6f65daaf%40thread.tacv2/Mission%20AI%20Hub?groupId=276ce13e-67d6-4fd0-82c9-9638d30b19ac&tenantId=7005d458-45be-48ae-8140-d43da96dd17b) if you are unsure how to combine them.

### Configure Codex CLI

1. Open Codex's settings file, `config.toml`:

   **ADAPT/Discover or macOS:**

   ```bash
   mkdir -p ~/.codex
   nano ~/.codex/config.toml
   ```

   These examples use the Nano text editor. If Nano is unavailable, open the same file in your usual editor, such as VS Code.

   **Windows PowerShell:**

   ```powershell
   New-Item -ItemType Directory -Force "$env:USERPROFILE\.codex" | Out-Null
   notepad "$env:USERPROFILE\.codex\config.toml"
   ```

   If Notepad asks whether to create the file, choose **Yes**.

2. Copy these settings into the file. They select NASA's service and the model named in the existing site configuration:

   ```toml
   model_provider = "nasa"
   model = "gpt-6-astra"

   [model_providers.nasa]
   name = "NASA LiteLLM"
   base_url = "https://proxy.fast.luna.nasa.gov"
   env_key = "NASA_LITELLM_API_KEY"
   wire_api = "responses"
   ```

3. Save and close the file. In Nano, press **Ctrl+O**, then **Enter** to save, and **Ctrl+X** to exit. In Notepad, choose **File → Save**, then close the window. Keep the filename `config.toml`, without a `.txt` extension.

4. Continue to step 6 to try a request. Codex will read the key you loaded in step 4; do not paste the key into this settings file. This NASA configuration does not require a separate ChatGPT login.

### Configure Claude Code

1. Open Claude Code's settings file, `settings.json`:

   **ADAPT/Discover or macOS:**

   ```bash
   mkdir -p ~/.claude
   chmod 700 ~/.claude
   nano ~/.claude/settings.json
   ```

   If Nano is unavailable, use your usual editor.

   **Windows PowerShell:**

   ```powershell
   New-Item -ItemType Directory -Force "$env:USERPROFILE\.claude" | Out-Null
   notepad "$env:USERPROFILE\.claude\settings.json"
   ```

   If Notepad asks whether to create the file, choose **Yes**.

2. Copy these settings into the file. Keep the quotation marks, braces, and commas as shown:

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

3. Save and close the file using the same editor shortcuts described above. Keep the filename as exactly `settings.json` (without a `.txt` extension).

4. Continue to step 6 to try a request. These settings select the model called **Sonnet** in NASA's configuration. See the [Claude supplement](claude_code_nmc_si_hub.md) for other choices and additional options.

## 6. Start and resume work

In the terminal where you loaded your key, open your project folder with `cd /path/to/project` (Windows: `cd "C:\path\to\project"`). Replace `/path/to/project` with your actual folder path. Then start the tool you configured:

| Action | Codex CLI | Claude Code |
| --- | --- | --- |
| Interactive development | `codex -a on-request -s workspace-write` | `claude --permission-mode acceptEdits` |
| Review/planning | `codex -a on-request -s read-only` | `claude --permission-mode plan` |
| Resume latest | `codex resume --last` | `claude --continue` |
| Choose a prior session | `codex resume` | `claude --resume` |

The first time you open a project, the tool may ask whether you trust the folder. Confirm if it is your project or another folder you trust.

**For your first request, try:** `Summarize this repository's purpose from its README without changing any files.`A successful reply should describe the project from its README. If you see a key or model error instead, check steps 4 and 5, then ask the Mission AI Hub team to confirm your access. If you would like more specific options for claude or codex, see their docs: [claude](claude_code_nmc_si_hub.md), [codex](codex_nmc_si_hub.md).

**Note**: it is common for the first prompt to take much longer than subsequent prompts (**upwards of 2 minutes with no output**); make sure to wait until an error message or response shows up, don't close the window early.

## Troubleshooting and updates

- **Command not found:** On ADAPT/Discover, repeat the `export PATH=...` command in step 3. On a local computer, close and reopen your terminal after installing.
- **Permission errors:** Check that your storage has free space and allows you to run programs. Ask site support if you are unsure.
- **Exec format error on an ADAPT Grace node:** Rerun the installer on that node as described in step 3. On other nodes, ask site support to check whether the installed program matches the processor.
- **Key or model errors:** Repeat key loading in step 4 and check the tool settings in step 5, then ask the Mission AI Hub team to confirm your model access. The client supplements cover additional troubleshooting.
- **Updates:** Close sessions using that installation across all nodes first. On ADAPT/Discover, rerun `install-nmc-clients.sh` with the same client flags. On local computers, rerun the Codex installation command or use `claude update` for Claude. Claude native installs auto-update by default. Follow [Anthropic's network-storage guidance](https://code.claude.com/docs/en/setup#install-on-network-storage) before concurrent use across nodes, so updates preserve executables still in use elsewhere.

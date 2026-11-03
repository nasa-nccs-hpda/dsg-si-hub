# Codex CLI advanced usage with NMC AI Hub

Complete [installation, key loading, NASA provider configuration, and a first session in the centralized guide](nmc_si_hub.md). This supplement covers Codex permission modes, session options, and troubleshooting for local workstations and ADAPT/Discover.

Documentation owner: Repository maintainers. Updated: 2026-11-03. The central guide retains this page's existing NASA endpoint and `gpt-6-astra` alias; current gateway access has not been independently tested.

## Project trust and configuration location

Allow Codex to prompt for project trust when you open a repository. If you deliberately persist a trust entry, use your own project's absolute path. Trust entries and UI-generated settings are not required in the [NASA provider example](nmc_si_hub.md#configure-codex-cli).

If you set `CODEX_HOME`, edit `config.toml` inside that directory instead of the default `~/.codex`. Keep that location consistent when installing, configuring, and launching Codex.

## Permission modes

Run these commands from the project directory after completing the central setup.

### Standard / Safe

Codex can work in the repository but requests approval when additional permissions are needed:

```bash
codex -a on-request -s workspace-write
```

### Autonomous + Sandboxed

Codex does not request command approvals; commands that exceed the sandbox permissions fail. The workspace-write sandbox limits writes, while reads and temporary-directory access follow the active sandbox policy:

```bash
codex -a never -s workspace-write
```

Use this mode for unattended tasks only after verifying sandbox support on your execution node.

### Read-Only

Codex can inspect and analyze the repository without modifying it:

```bash
codex -a on-request -s read-only
```

Useful for code review, debugging, and planning.

### Full Access / Unsafe

Codex runs autonomously without approval prompts or filesystem sandbox restrictions:

```bash
codex -a never -s danger-full-access
```

Use with caution. This allows Codex to execute commands and modify files outside the current repository.

## Resume a session

Resume the most recent Codex session:

```bash
codex resume --last
```

Resume autonomously:

```bash
codex -a never -s workspace-write resume --last
```

Resume with unrestricted access:

```bash
codex -a never -s danger-full-access resume --last
```

## Troubleshooting and references

- **Missing key or login prompt:** Confirm `model_provider = "nasa"` and that `NASA_LITELLM_API_KEY` is loaded in the launching shell. The custom provider does not require a separate ChatGPT login.
- **Model or Responses API errors:** Confirm the exact NASA alias, your key's permissions, and Responses/tool/streaming support with the Mission AI Hub team.
- **Sandbox startup or permission errors:** Check the execution node's sandbox support and allowed paths. Do not automatically switch to unrestricted mode to work around an error.
- **Legacy local configuration:** Replace the old guide's `OPENAI_API_BASE` / `openai_base_url` approach with the [central guide's provider table](nmc_si_hub.md#configure-codex-cli). An old `OPENAI_API_KEY` alone does not supply `NASA_LITELLM_API_KEY`.
- **Installation, architecture, updates, or slow first prompt:** See the [shared guide](nmc_si_hub.md).

Sources checked for client syntax on 2026-11-03: [OpenAI configuration reference](https://learn.chatgpt.com/docs/config-file/config-reference), [CLI reference](https://learn.chatgpt.com/docs/developer-commands?surface=cli), and local `codex --help` (0.166.0). NASA authentication and sandbox execution were not tested.

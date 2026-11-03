# Claude Code advanced usage with NMC AI Hub

Complete [installation, key loading, NASA gateway configuration, and a first session in the centralized guide](nmc_si_hub.md). This supplement covers Claude model selection, credential options, permission modes, and troubleshooting for local workstations and ADAPT/Discover.

Documentation owner: Repository maintainers. Updated: 2026-11-03. The central guide preserves this page's previous site-provided aliases and flags. Public client documentation was checked on that date; NASA authentication, model availability, and tool compatibility have not been independently tested.

## Configuration location and credential storage

If you set `CLAUDE_CONFIG_DIR`, use its `settings.json` instead of the default `~/.claude/settings.json`. Keep that location consistent when installing, configuring, and launching Claude Code.

The original site configuration put `ANTHROPIC_AUTH_TOKEN` in the JSON `env` block. The [central guide's environment mapping](nmc_si_hub.md#configure-claude-code) keeps the secret out of that file. If site policy requires private-file storage, restrict its permissions (`chmod 600 ~/.claude/settings.json` on Linux/macOS). Never commit the token. Load the mapping after `NASA_LITELLM_API_KEY` when using approved credential tooling.

## Model selection

`"model": "sonnet"` selects the configured `claude-sonnet-5-thinking` alias by default. The model aliases are supplied by NASA Mission AI Hub, not inferred from public Anthropic naming conventions. In Claude Code, use `/model` to switch models interactively, or start with `claude --model opus` or `claude --model haiku` when supported by your installed version.

## Permission modes

Run these commands from the project directory after completing the central setup.

### Standard / Safe

File edits and commands that are not already permitted prompt for approval according to the active rules; routine file reads normally do not:

```bash
claude --permission-mode default
```

### Auto-Accept Edits

Claude Code can modify files without asking about each edit, while potentially risky shell operations can still request approval:

```bash
claude --permission-mode acceptEdits
```

This is a practical default when using the AI Hub gateway and working interactively.

### Autonomous With Safety Review (if supported)

On versions and model configurations that support auto mode, Claude Code can use background checks instead of prompting for routine operations:

```bash
claude --permission-mode auto
```

**Important:** Auto mode is availability- and model-dependent, so it may not work with a NASA LiteLLM model alias. Unlike Codex's `-a never -s workspace-write`, `auto` is not itself a filesystem sandbox. Claude Code sandbox settings require separate configuration.

### Read-Only Planning

```bash
claude --permission-mode plan
```

Useful for architecture review, debugging plans, and exploring the repository before approving edits.

### Full Access / Unsafe

```bash
claude --dangerously-skip-permissions
```

This bypasses normal approval checks and does not configure a filesystem sandbox. Do not use it on shared ADAPT/Discover login nodes, production storage, or untrusted repositories. Only use it inside a properly isolated, approved development environment where damage is contained. Site policy or managed settings may prohibit this mode.

## Resume a session

Resume the latest session in the project:

```bash
claude --continue
```

Choose from previous sessions:

```bash
claude --resume
```

Resume while accepting edits:

```bash
claude --permission-mode acceptEdits --continue
```

## Troubleshooting

**Installation, architecture, updates, command lookup, or a slow first prompt:** See the [shared setup and troubleshooting guide](nmc_si_hub.md).

**Authentication errors or an unexpected Anthropic login prompt:** Check the effective `ANTHROPIC_BASE_URL` and `model` / `ANTHROPIC_DEFAULT_*_MODEL` aliases in your settings, confirm `ANTHROPIC_AUTH_TOKEN` is loaded in the launching shell, and unset a conflicting `ANTHROPIC_API_KEY`. Check local authentication policy before changing sign-in settings.

**`model not found` or unsupported request:** The proxy may not expose the selected alias through the Anthropic Messages API. Verify the exact Mission AI Hub alias and your token’s access to it.

**Requests work for chat but fail during coding:** Claude Code requires tool-use support, streaming and other Anthropic Messages compatibility features. Ask the NASA AI Hub team to verify support for `/v1/messages` for your selected model alias.

**Automatic mode unavailable:** Fall back to `acceptEdits`; do not automatically substitute `--dangerously-skip-permissions`.

## References

- [Claude Code installation](https://code.claude.com/docs/en/setup)
- [Claude Code permissions](https://code.claude.com/docs/en/permissions)
- [LiteLLM: Connect Claude Code](https://docs.litellm.ai/docs/proxy/client_setup/claude_code)
- [Claude Code gateway connection](https://code.claude.com/docs/en/llm-gateway-connect)
- [Claude Code CLI reference](https://code.claude.com/docs/en/cli-reference)
- [Shared NASA setup guide](nmc_si_hub.md)
- [Codex advanced usage](codex_nmc_si_hub.md)

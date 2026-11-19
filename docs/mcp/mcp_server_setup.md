# Create a mission MCP repository and use it with Codex or Claude Code

Documentation owner: Repository maintainers. Reviewed: 2026-11-19.
Status: Documentation and example syntax checked; server execution and client connections not tested.

Use one Model Context Protocol (MCP) repository per mission, such as `landsat-mcp`. The repository contains the mission's tools and curated knowledge. Each user clones it and registers a launch command; **Codex or Claude Code starts the local server automatically**. No separate hosting or manually running Python process is required.

Prerequisites: Python 3.11+, Git, [uv](https://docs.astral.sh/uv/getting-started/installation/), and Codex or Claude Code. Commands below use a macOS, Linux, or WSL terminal.

## 1. Create the mission repository

From the directory where you keep your repositories:

```bash
uv init --bare --python 3.11 landsat-mcp
cd landsat-mcp
git init
uv add 'mcp>=2,<3'
mkdir -p knowledge
vi server.py
```

Keep this as a standalone repository:

```text
landsat-mcp/
├── server.py              # MCP entry point and tools
├── knowledge/
│   └── overview.md        # Reviewed mission context and source links
├── pyproject.toml         # Python version and dependencies
├── uv.lock                # Resolved dependency versions
├── README.md              # Owner, purpose, setup, and available tools
└── .gitignore
```

As the repository grows, put mission API clients and processing logic in separate Python modules. Keep the MCP tools as small wrappers around that logic.

## 2. Add mission knowledge and a tool

Create `knowledge/overview.md` with this starter text, replacing it with reviewed mission information before sharing:

```markdown
# Landsat mission knowledge

Owner: TODO
Reviewed: TODO
Status: Starter template; mission information has not been added.

Add mission context, supported workflows, limitations, and authoritative source links here.
```

Save the following as `server.py`. This tool reads the repository's mission overview; it does not query a live Landsat service.

```python
from pathlib import Path

from mcp.server import MCPServer

mcp = MCPServer("landsat-mcp")
KNOWLEDGE_DIR = Path(__file__).resolve().parent / "knowledge"


@mcp.tool()
def get_mission_overview() -> str:
    """Read the curated Landsat mission overview and its source links."""
    return (KNOWLEDGE_DIR / "overview.md").read_text(encoding="utf-8")


if __name__ == "__main__":
    mcp.run(transport="stdio")
```

Add other mission functions with `@mcp.tool()`. Use descriptive names, typed inputs, and docstrings. Send diagnostic logs to stderr using Python's `logging` module; stdout is reserved for MCP messages.

## 3. Save and share on GitHub

Create `.gitignore`:

```gitignore
.venv/
__pycache__/
.env
```

Write a `README.md` identifying the owner, mission scope, tool descriptions, required credentials, and the installation commands below. This example needs no credentials. Never commit API keys or restricted mission data.

Create an empty `landsat-mcp` repository in your approved GitHub organization, then replace `YOUR_ORG` below:

```bash
git add server.py knowledge/overview.md pyproject.toml uv.lock README.md .gitignore
git commit -m "Add Landsat MCP server"
git branch -M main
git remote add origin https://github.com/YOUR_ORG/landsat-mcp.git
git push -u origin main
```

GitHub stores the code. The coding client runs a local copy.

## 4. Install the repository locally

Teammates clone it once, replacing `YOUR_ORG`:

```bash
git clone https://github.com/YOUR_ORG/landsat-mcp.git
cd landsat-mcp
uv sync --locked
```

If you created the repository above, stay in that directory and run only `uv sync --locked`.

Capture the launch paths in the same terminal:

```bash
MCP_PROJECT_DIR="$(pwd -P)"
MCP_UV_BIN="$(command -v uv)"
```

## 5. Register with Codex or Claude Code

Choose either or both clients. These commands save the launch configuration; **do not start `server.py` yourself**.

### Codex

```bash
codex mcp add landsat-mcp -- "$MCP_UV_BIN" --directory "$MCP_PROJECT_DIR" run --locked python server.py
codex mcp list
```

The registration is stored in Codex's user configuration, normally `~/.codex/config.toml`.

### Claude Code

```bash
claude mcp add --transport stdio --scope user landsat-mcp -- "$MCP_UV_BIN" --directory "$MCP_PROJECT_DIR" run --locked python server.py
claude mcp list
```

`--scope user` makes the server available across your projects. Each teammate registers their own local clone.

## 6. Start the client and use the mission tools

Run `codex` or `claude` from your working project. The client launches the registered MCP process automatically. Run `/mcp` to check that `landsat-mcp` is connected, then ask:

> Use landsat-mcp's get_mission_overview tool and summarize the mission overview.

Confirm an actual tool call appears and the result matches `knowledge/overview.md`. If you still have the starter file, expect a template notice rather than mission facts. If connection fails, check the registered paths and that `uv sync --locked` completed.

After reviewing repository updates, run `git pull --ff-only` and `uv sync --locked` inside the clone, then restart the client. Repeat the same repository pattern for other missions, using distinct names.

To remove a registration:

```bash
codex mcp remove landsat-mcp
claude mcp remove --scope user landsat-mcp
```

## References

- [Build an MCP server](https://modelcontextprotocol.io/docs/develop/build-server)
- [Official MCP Python SDK](https://github.com/modelcontextprotocol/python-sdk)
- [Codex MCP configuration](https://learn.chatgpt.com/docs/extend/mcp)
- [Claude Code MCP configuration](https://code.claude.com/docs/en/mcp)

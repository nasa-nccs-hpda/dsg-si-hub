#!/usr/bin/env bash
# Install native clients in the user's preconfigured NOBACKUP storage.
# See docs/nmc/nmc_si_hub.md for setup, credentials, and validation limitations.
set -euo pipefail

usage() {
    cat <<'EOF'
Usage: bash install-nmc-clients.sh [--codex] [--claude]

  --codex     Install Codex CLI.
  --claude    Install Claude Code.
  --help      Show this help.

No flags installs both. Run on an ADAPT/Discover login node first.
NOBACKUP must already point to your personal storage. Do not use sudo.
Adds ~/.local/bin to PATH in ~/.bashrc for future Bash terminals.
Close client sessions on all nodes before rerunning or changing architecture.
EOF
}

nmc_codex=false
nmc_claude=false
if (( $# == 0 )); then
    nmc_codex=true
    nmc_claude=true
fi
for nmc_arg in "$@"; do
    case "$nmc_arg" in
        --codex) nmc_codex=true ;;
        --claude) nmc_claude=true ;;
        --help|-h) usage; exit 0 ;;
        *) echo "Unknown option: $nmc_arg" >&2; usage >&2; exit 2 ;;
    esac
done

fail() { echo "Error: $*" >&2; exit 1; }
[[ $(uname -s) == Linux ]] || fail "This script is for ADAPT/Discover Linux. See the guide for local installation."
[[ -z ${SUDO_USER:-} ]] || fail "Run this script as yourself, without sudo."
[[ -n ${NOBACKUP:-} ]] || fail "NOBACKUP is not set. Reconnect to your site account or contact support."
[[ $NOBACKUP == /* && -d $NOBACKUP && -w $NOBACKUP ]] || fail "NOBACKUP must be an existing, writable absolute directory."
for nmc_command in curl readlink mktemp; do
    command -v "$nmc_command" >/dev/null || fail "Required command is missing: $nmc_command"
done
nmc_arch=$(uname -m)
case "$nmc_arch" in
    x86_64|amd64) nmc_arch=x86_64 ;;
    aarch64|arm64) nmc_arch=aarch64 ;;
    *) fail "Unsupported processor: $nmc_arch" ;;
esac
if $nmc_codex; then
    [[ ${CODEX_HOME:-$HOME/.codex} == "$HOME/.codex" ]] || fail "A custom CODEX_HOME is set. Use the guide to review this existing installation first."
fi
if $nmc_claude; then
    [[ ${CLAUDE_CONFIG_DIR:-$HOME/.claude} == "$HOME/.claude" ]] || fail "A custom CLAUDE_CONFIG_DIR is set. Review this existing installation first."
    [[ ${XDG_DATA_HOME:-$HOME/.local/share} == "$HOME/.local/share" ]] || fail "A custom XDG_DATA_HOME is set. Review this existing installation first."
fi

umask 077
nmc_root="$(readlink -f "$NOBACKUP")/nmc-ai"
nmc_bin="$HOME/.local/bin"

# Check every destination before making changes. Only architecture-specific
# links created by this script may be redirected; shared settings stay put.
check_link() {
    local target=$1 link=$2 switchable=${3:-false} current
    if [[ -L $link ]]; then
        current=$(readlink -f "$link")
        [[ $current == "$target" ]] && return
        if [[ $switchable == true && -f $nmc_root/.managed-$nmc_client ]]; then
            case "$current" in
                "$nmc_root/x86_64/$nmc_component"|"$nmc_root/aarch64/$nmc_component") return ;;
            esac
        fi
    elif [[ ! -e $link ]]; then
        return
    fi
    fail "Existing path needs review: $link. It has been left in place; see the guide's existing-installation note."
}

check_launcher() {
    local launcher="$nmc_bin/$nmc_client" current
    if [[ -e $launcher || -L $launcher ]]; then
        [[ -L $launcher && -f $nmc_root/.managed-$nmc_client ]] || fail "Existing launcher needs review: $launcher"
        current=$(readlink -f "$launcher")
        [[ $current == "$nmc_root/"* ]] || fail "Existing launcher points outside this installation: $launcher"
    fi
}

link_dir() {
    local target=$1 link=$2
    mkdir -p "$target" "$(dirname "$link")"
    if [[ -L $link ]]; then
        [[ $(readlink -f "$link") == "$target" ]] && return
        echo "Selecting $nmc_arch installation: $link"
        ln -sfnT "$target" "$link"
    else
        ln -sT "$target" "$link"
    fi
}

for nmc_client in codex claude; do
    if [[ $nmc_client == codex ]]; then
        $nmc_codex || continue
        check_link "$nmc_root/codex" "$HOME/.codex"
        nmc_component=codex-standalone
        check_link "$nmc_root/$nmc_arch/$nmc_component" "$HOME/.codex/packages/standalone" true
    else
        $nmc_claude || continue
        check_link "$nmc_root/claude-config" "$HOME/.claude"
        nmc_component=claude-install
        check_link "$nmc_root/$nmc_arch/$nmc_component" "$HOME/.local/share/claude" true
    fi
    check_launcher
done

nmc_installer=$(mktemp /tmp/nmc-ai-install.XXXXXX)
trap 'rm -f "$nmc_installer"' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM
mkdir -p "$nmc_bin"
case ":$PATH:" in
    *":$nmc_bin:"*) ;;
    *) export PATH="$nmc_bin:$PATH" ;;
esac
echo "Using your NOBACKUP storage: $nmc_root"
echo "Processor: $nmc_arch. Close sessions on other nodes before updating."

if $nmc_codex; then
    echo "[Codex] Preparing storage for the program, settings, and sessions..."
    link_dir "$nmc_root/codex" "$HOME/.codex"
    link_dir "$nmc_root/$nmc_arch/codex-standalone" "$HOME/.codex/packages/standalone"
    touch "$nmc_root/.managed-codex"
    echo "[Codex] Downloading the official installer..."
    curl -fsSL https://chatgpt.com/codex/install.sh -o "$nmc_installer"
    echo "[Codex] Installing; this may take a few minutes..."
    TMPDIR=/tmp CODEX_INSTALL_DIR="$nmc_bin" CODEX_NON_INTERACTIVE=1 sh "$nmc_installer"
    "$nmc_bin/codex" --version
    echo "[Codex] Installation complete."
fi

if $nmc_claude; then
    echo "[Claude] Preparing storage for the program, settings, and sessions..."
    link_dir "$nmc_root/claude-config" "$HOME/.claude"
    link_dir "$nmc_root/$nmc_arch/claude-install" "$HOME/.local/share/claude"
    touch "$nmc_root/.managed-claude"
    echo "[Claude] Downloading the official installer..."
    curl -fsSL https://claude.ai/install.sh -o "$nmc_installer"
    echo "[Claude] Installing; this may take a few minutes..."
    TMPDIR=/tmp bash "$nmc_installer"
    "$nmc_bin/claude" --version
    echo "[Claude] Installation complete."
fi

echo '[PATH] Setting up commands for future Bash terminals...'
nmc_path_marker='# NMC clients: commands in ~/.local/bin'
if ! grep -Fqx -- "$nmc_path_marker" "$HOME/.bashrc" 2>/dev/null; then
    cat >> "$HOME/.bashrc" <<'EOF'

# NMC clients: commands in ~/.local/bin
case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) export PATH="$HOME/.local/bin:$PATH" ;;
esac
EOF
    echo '[PATH] Added command setup to ~/.bashrc.'
else
    echo '[PATH] Command setup is already in ~/.bashrc.'
fi

echo 'Finished. Open a new Bash terminal, then check the installed versions.'
echo 'Follow steps 4 and 5 in the setup guide to connect to Mission AI Hub.'

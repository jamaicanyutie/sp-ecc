#!/usr/bin/env bash
# Single-line installer for sp-ecc (Superpowers + Everything Claude Code) on OpenCode.
# macOS / Linux / WSL:  curl -fsSL https://raw.githubusercontent.com/jamaicanyutie/sp-ecc/master/scripts/install.sh | bash
set -euo pipefail

REPO_URL="https://github.com/jamaicanyutie/sp-ecc.git"
CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
SP_ECC_DIR="$CONFIG_DIR/sp-ecc"

echo "[sp-ecc] config dir: $CONFIG_DIR"

mkdir -p "$CONFIG_DIR/plugins" "$CONFIG_DIR/skills"

if [ -d "$SP_ECC_DIR/.git" ]; then
  echo "[sp-ecc] updating existing clone..."
  git -C "$SP_ECC_DIR" pull --ff-only
else
  echo "[sp-ecc] cloning repository..."
  mkdir -p "$SP_ECC_DIR"
  git clone "$REPO_URL" "$SP_ECC_DIR"
fi

echo "[sp-ecc] linking plugin and skills..."
rm -f "$CONFIG_DIR/plugins/sp-ecc.js"
rm -rf "$CONFIG_DIR/skills/sp-ecc"
ln -s "$SP_ECC_DIR/.opencode/plugins/sp-ecc.js" "$CONFIG_DIR/plugins/sp-ecc.js"
ln -s "$SP_ECC_DIR/skills" "$CONFIG_DIR/skills/sp-ecc"

echo "[sp-ecc] done. Restart opencode."
echo "[sp-ecc] verify: opencode debug skill && opencode run \"say hi\""
ls -l "$CONFIG_DIR/plugins/sp-ecc.js" "$CONFIG_DIR/skills/sp-ecc"
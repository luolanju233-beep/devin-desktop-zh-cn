#!/bin/bash
# Devin Desktop 中文语言包卸载脚本（macOS）
# Uninstall the Chinese (Simplified) language pack and restore English UI.
set -euo pipefail

EXT_ID="MS-CEINTL.vscode-language-pack-zh-hans"
ARGV="$HOME/.devin/argv.json"

CLI=""
for candidate in \
  "/Applications/Devin.app/Contents/Resources/app/bin/devin-desktop" \
  "$HOME/Applications/Devin.app/Contents/Resources/app/bin/devin-desktop" \
  "/Applications/Devin.app/Contents/Resources/app/bin/devin" \
  "$HOME/Applications/Devin.app/Contents/Resources/app/bin/devin"; do
  if [ -x "$candidate" ]; then
    CLI="$candidate"
    break
  fi
done

if [ -z "$CLI" ] && command -v devin-desktop >/dev/null 2>&1; then
  CLI="devin-desktop"
fi

if [ -n "$CLI" ]; then
  echo "==> Uninstalling language pack extension | 正在卸载中文语言包..."
  "$CLI" --uninstall-extension "$EXT_ID" || true
else
  echo "WARNING: Devin Desktop CLI not found; skipping extension removal."
  echo "警告：未找到 Devin Desktop 命令行工具，跳过扩展卸载。"
fi

if [ -f "$ARGV" ]; then
  echo "==> Restoring display language to English | 正在恢复英文界面..."
  tmp="$(mktemp)"
  sed -E 's/"locale"[[:space:]]*:[[:space:]]*"[^"]*"/"locale": "en"/' "$ARGV" > "$tmp"
  mv "$tmp" "$ARGV"
fi

echo "==> Done. Please fully quit and reopen Devin Desktop (Cmd+Q)."
echo "==> 完成。请完全退出并重新打开 Devin Desktop（Cmd+Q）。"

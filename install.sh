#!/bin/bash
# Devin Desktop 中文语言包安装脚本（macOS）
# Install the Chinese (Simplified) language pack for Devin Desktop on macOS.
set -euo pipefail

EXT_ID="MS-CEINTL.vscode-language-pack-zh-hans"
LOCALE="zh-cn"
ARGV="$HOME/.devin/argv.json"

echo "==> Locating Devin Desktop CLI | 正在查找 Devin Desktop 命令行工具..."

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

if [ -z "$CLI" ]; then
  echo "ERROR: Devin Desktop not found. Please install it from https://devin.ai/download first."
  echo "错误：未找到 Devin Desktop，请先从 https://devin.ai/download 安装。"
  exit 1
fi

echo "    Using CLI: $CLI"

echo "==> Installing language pack extension | 正在安装中文（简体）语言包..."
"$CLI" --install-extension "$EXT_ID" --force

echo "==> Setting display language to $LOCALE | 正在设置显示语言..."
mkdir -p "$(dirname "$ARGV")"

if [ ! -f "$ARGV" ]; then
  printf '{\n\t"locale": "%s"\n}\n' "$LOCALE" > "$ARGV"
else
  if grep -q '"locale"[[:space:]]*:' "$ARGV"; then
    # Replace the existing locale value.
    tmp="$(mktemp)"
    sed -E 's/"locale"[[:space:]]*:[[:space:]]*"[^"]*"/"locale": "'"$LOCALE"'"/' "$ARGV" > "$tmp"
    mv "$tmp" "$ARGV"
  else
    # Insert locale right after the first opening brace.
    tmp="$(mktemp)"
    awk -v loc="$LOCALE" '
      BEGIN { done = 0 }
      !done && /\{/ {
        print
        printf "\t\"locale\": \"%s\",\n", loc
        done = 1
        next
      }
      { print }
    ' "$ARGV" > "$tmp"
    mv "$tmp" "$ARGV"
  fi
fi

echo ""
echo "==> Done | 安装完成"
echo "    Please fully quit and reopen Devin Desktop (Cmd+Q) to apply the Chinese UI."
echo "    请完全退出并重新打开 Devin Desktop（Cmd+Q）以应用中文界面。"
echo "    Note: use File -> New IDE Window for the fully localized editor surface;"
echo "    the Agents command-center window stays in English (upstream limitation)."
echo "    提示：使用“文件 -> New IDE Window”打开已汉化的编辑器界面；"
echo "    Agents 智能体面板暂时仍为英文（官方界面限制）。"

# Devin Desktop Chinese Language Pack | Devin Desktop 中文语言包

**One-command Chinese (Simplified) localization for Devin Desktop on macOS and Windows: installs the official language pack extension and switches the display language automatically.**

**一条命令完成 Devin Desktop 的中文（简体）汉化，支持 macOS 和 Windows：自动安装官方中文语言包扩展并切换显示语言。**

Devin Desktop (Cognition) 默认只有英文界面。本仓库提供两个平台的安装脚本，自动完成两件事：安装 `MS-CEINTL.vscode-language-pack-zh-hans` 语言包扩展，并在 `argv.json` 中写入 `locale: zh-cn`。重启客户端后，经典 IDE 编辑器界面（菜单、设置、命令面板等）即变为中文。

Devin Desktop ships in English only. The scripts in this repository automate the two steps required to localize it: installing the `MS-CEINTL.vscode-language-pack-zh-hans` extension and setting `locale: zh-cn` in `argv.json`. After a restart, the classic IDE editor surface (menus, settings, command palette) appears in Chinese.

## Choose Your Platform | 选择你的平台

- **macOS:** run `zsh install.sh` in Terminal. See [macOS installation](#macos-installation--macos-安装).
- **macOS：** 在终端运行 `zsh install.sh`，查看下方 macOS 安装说明。
- **Windows:** run `powershell -NoProfile -ExecutionPolicy Bypass -File .\windows\install.ps1` in PowerShell. See [Windows installation](#windows-installation--windows-安装).
- **Windows：** 在 PowerShell 运行上述 Windows 安装命令，查看下方 Windows 安装说明。

## What Gets Translated | 汉化范围说明

**Important | 重要提示：**

- The **classic IDE editor window** (opened via `File → New IDE Window`) is fully localized: menus 文件/编辑/选择/查看/转到/运行/终端/帮助, settings, command palette, and built-in editor UI.
- **经典 IDE 编辑器窗口**（通过 `文件 → New IDE Window` 打开）完全汉化：菜单、设置、命令面板及内置编辑器界面。
- The **Agents command-center window** (the default window with "New session / Sessions") is a custom interface built by Cognition. It is not covered by the Microsoft language pack and currently remains in English. This is an upstream limitation, not a misconfiguration.
- **Agents 智能体面板**（默认窗口，含 New session / Sessions）是 Cognition 定制的界面，不在语言包覆盖范围内，目前保持英文。这是官方现状，不是配置失败。

## Requirements | 系统要求

### macOS

- macOS on Apple Silicon or Intel.
- 搭载 Apple Silicon 或 Intel 处理器的 macOS。
- Devin Desktop installed from https://devin.ai/download.
- 已从 https://devin.ai/download 安装 Devin Desktop。

### Windows

- Windows 10 or Windows 11 (x64 or ARM64).
- Windows 10 或 Windows 11（x64 或 ARM64）。
- Devin Desktop installed (per-user install at `%LOCALAPPDATA%\Programs\Devin`).
- 已安装 Devin Desktop（默认每用户安装于 `%LOCALAPPDATA%\Programs\Devin`）。
- No administrator access required.
- 不需要管理员权限。

## macOS Installation | macOS 安装

### Option 1: Clone from GitHub | 方式一：从 GitHub 克隆

```bash
git clone https://github.com/luolanju233-beep/devin-desktop-zh-cn.git
cd devin-desktop-zh-cn
zsh install.sh
```

### Option 2: Download ZIP | 方式二：下载 ZIP

On the GitHub repository page, select **Code → Download ZIP**. Extract the archive, open Terminal in the project directory, and run `zsh install.sh`.

在 GitHub 仓库页面选择 **Code → Download ZIP**，解压后在项目目录打开终端并运行 `zsh install.sh`。

The macOS installer locates the `devin-desktop` CLI inside `Devin.app`, installs the language pack extension, and writes `locale: zh-cn` into `~/.devin/argv.json`. No `sudo` access is required.

macOS 安装脚本会在 `Devin.app` 内找到 `devin-desktop` 命令行工具，安装语言包扩展，并向 `~/.devin/argv.json` 写入 `locale: zh-cn`，不需要 `sudo`。

## Windows Installation | Windows 安装

### Option 1: Clone from GitHub | 方式一：从 GitHub 克隆

Open **Windows PowerShell** and run:

打开 **Windows PowerShell**，运行：

```powershell
git clone https://github.com/luolanju233-beep/devin-desktop-zh-cn.git
cd devin-desktop-zh-cn
powershell -NoProfile -ExecutionPolicy Bypass -File .\windows\install.ps1
```

### Option 2: Download ZIP | 方式二：下载 ZIP

On the GitHub repository page, select **Code → Download ZIP**. Extract the archive, open PowerShell in the project directory, and run:

在 GitHub 仓库页面选择 **Code → Download ZIP**，解压后在项目目录打开 PowerShell 并运行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\windows\install.ps1
```

The Windows installer locates `%LOCALAPPDATA%\Programs\Devin\bin\devin-desktop.cmd`, installs the language pack extension, and writes `locale: zh-cn` into `%USERPROFILE%\.devin\argv.json`. It does not require administrator access.

Windows 安装脚本会定位 `%LOCALAPPDATA%\Programs\Devin\bin\devin-desktop.cmd`，安装语言包扩展，并向 `%USERPROFILE%\.devin\argv.json` 写入 `locale: zh-cn`。不需要管理员权限。

The `-ExecutionPolicy Bypass` argument applies only to this installer invocation; it does not change the computer's persistent PowerShell execution policy.

命令中的 `-ExecutionPolicy Bypass` 只对本次安装进程生效，不会永久修改电脑的 PowerShell 执行策略。

## Usage | 使用

After installation:

安装完成后：

1. Fully quit Devin Desktop (macOS: `Cmd + Q`; Windows: close all Devin windows) and reopen it.
2. 完全退出 Devin Desktop（macOS 按 `Cmd + Q`；Windows 关闭所有 Devin 窗口）并重新打开。
3. Open `File → New IDE Window` — menus and editor UI are now in Chinese (文件、编辑、查看……).
4. 打开 `File → New IDE Window`，菜单和编辑器界面即显示中文（文件、编辑、查看……）。

To verify the extension is installed:

验证扩展是否已安装：

```bash
# macOS
/Applications/Devin.app/Contents/Resources/app/bin/devin-desktop --list-extensions
```

```powershell
# Windows
& "$env:LOCALAPPDATA\Programs\Devin\bin\devin-desktop.cmd" --list-extensions
```

The output should contain `ms-ceintl.vscode-language-pack-zh-hans`.

输出中应包含 `ms-ceintl.vscode-language-pack-zh-hans`。

## Uninstallation | 卸载

### macOS

```bash
zsh uninstall.sh
```

The macOS uninstaller removes the language pack extension and restores `locale: en` in `~/.devin/argv.json`.

macOS 卸载脚本会移除语言包扩展，并将 `~/.devin/argv.json` 恢复为 `locale: en`。

### Windows

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\windows\uninstall.ps1
```

The Windows uninstaller removes the language pack extension and restores `locale: en` in `%USERPROFILE%\.devin\argv.json`.

Windows 卸载脚本会移除语言包扩展，并将 `%USERPROFILE%\.devin\argv.json` 恢复为 `locale: en`。

## How It Works | 工作原理

Devin Desktop is built on the VS Code engine. VS Code localizes its core UI through language pack extensions plus a `locale` entry in the user-level `argv.json` file. These scripts perform exactly those two official steps—nothing is patched, injected, or modified inside the application itself.

Devin Desktop 基于 VS Code 引擎构建。VS Code 通过"语言包扩展 + 用户级 `argv.json` 中的 `locale` 配置"实现界面本地化。本脚本严格只执行这两个官方步骤——不修改、不注入应用本身的任何文件。

- Language pack source | 语言包来源：`MS-CEINTL.vscode-language-pack-zh-hans` (Microsoft official Chinese Simplified language pack, distributed via the open marketplace).
- Config file | 配置文件：`~/.devin/argv.json` (macOS) / `%USERPROFILE%\.devin\argv.json` (Windows)。
- Both steps are idempotent: re-running the installer is safe.
- 两个步骤都是幂等的，重复运行安装脚本没有副作用。

## License | 许可证

[MIT](LICENSE) © 2026 luolanju233-beep

The bundled scripts are MIT licensed. The language pack extension itself is published by Microsoft under its own license.

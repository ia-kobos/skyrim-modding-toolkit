# Getting Started -- Detailed Guide

This guide walks through a first setup of the Skyrim Codex Modding Toolkit on Windows.

## What You Are Setting Up

The toolkit gives Codex project instructions, Skyrim-specific reference material, guided skills, and wrappers for common modding tools. It can help inspect plugins, analyze Papyrus scripts, troubleshoot a modlist, and build mod projects while following the safety rules in `AGENTS.md`.

## Step 1: Install Codex

Use either the Codex desktop app or the command-line interface. See the [official Codex documentation](https://developers.openai.com/codex/) for the current options.

For the command line, open PowerShell and use the official Windows installer:

```powershell
powershell -ExecutionPolicy Bypass -c "irm https://chatgpt.com/codex/install.ps1 | iex"
```

If you already use Node.js and npm, this is also supported:

```powershell
npm install -g @openai/codex
```

## Step 2: Find Your Skyrim Folder

In Steam, open **Library**, right-click Skyrim, choose **Properties**, then **Installed Files**, then **Browse**. Copy the path from File Explorer's address bar.

Common examples are:

- `C:\Steam\steamapps\common\SkyrimVR`
- `D:\SteamLibrary\steamapps\common\SkyrimVR`
- `C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition`

If you use MO2, setup will separately ask for or detect the MO2 instance and active profile. The physical game folder is not the same thing as MO2's virtual `Data` view.

## Step 3: Extract the Toolkit

Download the toolkit archive and extract it directly into the Skyrim folder. The result should include `AGENTS.md`, `KNOWLEDGEBASE.md`, `setup.sh`, and `.agents/skills/`.

The toolkit does not replace the need for a modlist backup. Keep your original downloads and back up any files you plan to modify.

## Step 4: Open Codex in the Skyrim Folder

In the desktop app, open the Skyrim folder as the working folder.

From PowerShell, either change directories first:

```powershell
cd "C:\Steam\steamapps\common\SkyrimVR"
codex
```

Or start Codex there directly:

```powershell
codex -C "C:\Steam\steamapps\common\SkyrimVR"
```

## Step 5: Paste the Setup Prompt

Copy the following line into Codex. It is also saved as `SETUP_PROMPT.txt`.

```text
I just installed the Skyrim Codex Modding Toolkit into this folder. Run "bash setup.sh" to configure it. After setup, ask me which optional modding tools I'd like (xeditlib, Champollion, Caprica, Spriggit, AutoMod CLI, PyFFI, PyNifly, Blender, NifSkope, ReSaver CLI) and install only the ones I approve. AutoMod CLI adds NIF mesh editing, BSA archive tools, audio processing, and MCM menu generation -- install it by cloning https://github.com/SpookyPirate/spookys-automod-toolkit into tools/automod and building only the CLI project (dotnet build tools/automod/src/SpookysAutomod.Cli -c Release), then use tools/automod-cli.sh. PyFFI + PyNifly add NIF geometry and animation/controller authoring; Blender (headless) + NifSkope add mesh repair and render verification. ReSaver CLI adds headless .ess save parsing, cross-referencing, cleaning, and changeform diagnostics (download ReSaver.jar from Nexus mod 5031 into tools/resaver-cli/; requires JDK 17+, with JDK 21 LTS recommended). Separately, tell me about DevBench but do not install it: it is an optional dev-only SKSE plugin (Nexus mod 181326 by alandtse) that runs a localhost server inside the running game for live state, console commands, and Papyrus calls. Because it is a mod, I will install it through my mod manager if I want it; never copy it into Data/ directly. The bundled wrappers tools/devbench-cli.sh and tools/cosave-cli.sh require no toolkit setup beyond their documented dependencies. Tailor the environment to my Skyrim version and installation, which may or may not be VR. Also ask whether I want the optional Nexus API integration; if yes, explain how to get a Personal API Key and save it to the gitignored tools/.nexus_api_key file. Explain everything in plain English and ask any questions you need to.
```

Setup configures paths and then asks before installing any optional external tool. The Codex edition does not install automatic filesystem hooks; its operating rules live in `AGENTS.md`. See [Safety Philosophy](safety-philosophy.md) for the exact boundary.

## Step 6: Use the Toolkit

Open Codex in the same folder for later sessions. Ask in plain English, or explicitly invoke one of the bundled skills such as `$inspect-esp`, `$port-to-vr`, or `$create-mod`.

Useful bundled wrappers include:

| Script | Purpose |
|---|---|
| `devbench-cli.sh` | Inspect a running game through an independently installed DevBench mod. |
| `esp-verify-wrapper.sh` | Compare plugin cross-references around a risky bulk edit. |
| `spriggit-cli.sh` | Serialize and rebuild plugins through Spriggit. |
| `automod-cli.sh` | Run an independently installed AutoMod CLI build. |
| `resaver-cli.sh` | Perform headless save parsing and diagnostics. |
| `cosave-cli.sh` | Produce a read-only structural survey of an SKSE co-save. |
| `nexus.sh` | Query Nexus metadata without printing the API key. |

## Troubleshooting

**`codex` is not recognized**

Restart PowerShell after installation, then check `codex --version`. If it still fails, use the current installation instructions in the official documentation.

**`setup.sh` is not found**

Confirm the toolkit was extracted into the folder Codex currently has open and that `setup.sh` is visible there.

**A modding tool is unavailable**

Most large or licensed tools are optional and are not bundled. Ask Codex to check the specific wrapper's documented dependency, then approve only the installation you want.

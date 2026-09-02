---
name: skyrim-mcm
description: Generate and edit SkyUI Mod Configuration Menus with the AutoMod CLI — create a config, add toggle and slider options across pages, then inspect and validate it. Use when the user wants in-game settings for their mod, an MCM menu, or configurable toggles and sliders.
---

# MCM Menu Generation

Use the AutoMod CLI to create mod configuration menus. Always use `--json` for output.

```bash
bash tools/automod-cli.sh mcm <command> [args] --json
```

## Commands

- `mcm create <modName> <displayName> [--output <config.json>]` — create new MCM config
- `mcm add-toggle <config> <id> <text> [--help-text <text>] [--page <name>]` — add toggle option
- `mcm add-slider <config> <id> <text> [--min <n>] [--max <n>] [--step <n>] [--page <name>]` — add slider
- `mcm info <config>` — inspect MCM configuration
- `mcm validate <config>` — check for errors

## VR Note

MCM menus require **SkyUI VR** (the VR fork, not regular SkyUI). Standard SkyUI is incompatible with VR.

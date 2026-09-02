---
name: inspect-esp
description: Inspect an ESP/ESM plugin file and show a summary of all records
---

# Inspect ESP Plugin

Inspect the ESP/ESM plugin identified in the user's request and provide a comprehensive summary. Resolve its actual path from the configured mod-manager paths; do not assume it lives in a physical `Data/` directory.

## Workflow

### Option A: Spriggit (preferred — human-readable output)

1. Discover the installed Spriggit version with `spriggit --version`.
2. Create a temporary output directory outside the game directory.
3. Serialize the ESP to YAML with the repository wrapper:
   ```bash
   bash tools/spriggit-cli.sh serialize --InputPath "<plugin-path>" --OutputPath "<temporary-output-directory>" --GameRelease SkyrimSE --PackageName Spriggit.Yaml --PackageVersion "<installed-version>" --ErrorOnUnknown
   ```
4. Read the generated YAML files to understand the record structure.
5. Summarize record types, counts, editor IDs, masters, and notable records.

### Option B: xeditlib (programmatic — for deeper analysis)

If xeditlib is installed and the plugin is visible through the configured game data path, run:
```bash
node examples/inspect-esp.js "<PluginName.esp>"
```

Or write a targeted inspection script if the example doesn't cover what's needed.

## Output Format

Provide a structured summary:
- **File info**: name, masters, record count, flags (ESM/ESL)
- **Record type breakdown**: count per signature (SPEL, MGEF, WEAP, etc.)
- **Notable records**: list editor IDs with brief descriptions
- **Scripts**: any VMAD-attached scripts and their properties
- **Potential issues**: casting type mismatches, missing ONAM, ESL FormID range violations

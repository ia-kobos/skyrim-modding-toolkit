# Safety Philosophy

## Why Safety Matters

A modded Skyrim installation is an interdependent system. A bad plugin edit, an incorrect path, or an overwritten file can cause crashes or hours of recovery work. VR also has compatibility traps that do not exist in flat Skyrim.

The toolkit therefore uses several independent safety layers:

1. **Known pitfalls:** `KNOWLEDGEBASE.md` records engine quirks and tested workflows.
2. **Project rules:** `AGENTS.md` requires investigation, explicit assumptions, and a confidence rating before changes.
3. **Human control:** Codex asks for approval when its environment or the requested action requires it. Keep game-file changes tightly scoped.
4. **Preview before write:** ESP and asset workflows should produce a read-only preview before an approved write pass.
5. **Tool-specific validation:** Binary formats go through xEdit, Spriggit, the Creation Kit, or another format-aware tool rather than ordinary text editing.
6. **Recoverable state:** Keep the mod manager's original downloads, version-control source projects, and manual backups of anything that cannot be regenerated.

## Important Boundary

This Codex edition does **not** install automatic filesystem hooks. `AGENTS.md` provides operating instructions, not an invisible enforcement layer. Codex approvals and sandboxing can add protection, but they do not replace backups or careful review.

## Practical Rules

- Never work directly on the only copy of a plugin, save, mesh, or script.
- Confirm the active game version, mod-manager instance, profile, and real source paths before editing.
- Treat MO2's virtual filesystem separately from the physical stock `Data` folder.
- Preview bulk operations and compare record references before and after risky plugin edits.
- Validate generated binaries with an independent reader before launching the game.
- Install actual mods through the user's mod manager; do not silently copy them into `Data`.

`setup.sh` creates `.toolkit/backups/` as a local place for manual working backups. `scripts/generate-baseline.sh` can record checksums of the toolkit's core instruction files. Neither replaces a complete modlist or source backup.

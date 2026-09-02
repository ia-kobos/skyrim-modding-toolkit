#!/bin/bash
# Generate SHA256 checksums for critical game files
# Run manually to create a baseline snapshot for drift detection
#
# Usage: bash scripts/generate-baseline.sh
#
# SETUP: Set GAME_DIR and CONFIG_DIR below to match your installation.

GAME_DIR="${GAME_DIR:-$(pwd)}"
CONFIG_DIR="${CONFIG_DIR:-$HOME/Documents/My Games/Skyrim VR}"
OUTPUT="$GAME_DIR/.toolkit/baseline_checksums.txt"

mkdir -p "$GAME_DIR/.toolkit"

echo "Generating baseline checksums..."
echo "Game dir:   $GAME_DIR"
echo "Config dir: $CONFIG_DIR"
echo ""

echo "# Baseline checksums generated $(date '+%Y-%m-%d %H:%M:%S')" > "$OUTPUT"
echo "" >> "$OUTPUT"

# INI configs
echo "## INI Configs" >> "$OUTPUT"
for f in "$CONFIG_DIR"/*.ini; do
    [ -f "$f" ] && sha256sum "$f" >> "$OUTPUT"
done

# SKSE plugin configs
echo "" >> "$OUTPUT"
echo "## SKSE Plugin Configs" >> "$OUTPUT"
find "$GAME_DIR/Data/SKSE/Plugins" -maxdepth 1 -name "*.ini" -exec sha256sum {} \; >> "$OUTPUT" 2>/dev/null

# ESP/ESM files (just the ones in Data/ root, not BSA contents)
echo "" >> "$OUTPUT"
echo "## Plugin Files (ESP/ESM/ESL)" >> "$OUTPUT"
find "$GAME_DIR/Data" -maxdepth 1 \( -name "*.esp" -o -name "*.esm" -o -name "*.esl" \) -exec sha256sum {} \; >> "$OUTPUT" 2>/dev/null

# Load order files
echo "" >> "$OUTPUT"
echo "## Load Order Files" >> "$OUTPUT"
LO_DIR="$HOME/AppData/Local/Skyrim VR"
[ -f "$LO_DIR/loadorder.txt" ] && sha256sum "$LO_DIR/loadorder.txt" >> "$OUTPUT"
[ -f "$LO_DIR/plugins.txt" ] && sha256sum "$LO_DIR/plugins.txt" >> "$OUTPUT"

# Project files
echo "" >> "$OUTPUT"
echo "## Project Files" >> "$OUTPUT"
sha256sum "$GAME_DIR/AGENTS.md" >> "$OUTPUT" 2>/dev/null
sha256sum "$GAME_DIR/KNOWLEDGEBASE.md" >> "$OUTPUT" 2>/dev/null

LINES=$(wc -l < "$OUTPUT")
echo "Baseline written to $OUTPUT ($LINES lines)"
echo "Re-run anytime to compare against current state."

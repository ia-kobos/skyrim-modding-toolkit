#!/bin/bash
# nexus.sh -- tiny Nexus Mods API helper for the Skyrim Codex Toolkit.
# Resolves your free Personal API Key (file first, then env) and queries the v1 API.
# The key is NEVER printed. Get a key: https://www.nexusmods.com/users/myaccount?tab=api
#
# Usage:
#   bash tools/nexus.sh mod <mod_id> [game_domain]   # mod summary (default domain: skyrimspecialedition)
#   bash tools/nexus.sh validate                     # confirm the key works (prints account name only)
#   bash tools/nexus.sh raw <api_path>               # raw GET of any /v1/... path, prints JSON
#
# Key resolution order:  tools/.nexus_api_key  ->  $NEXUS_API_KEY
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KEY_FILE="$SCRIPT_DIR/.nexus_api_key"

KEY=""
if [ -s "$KEY_FILE" ]; then
    KEY="$(tr -d ' \t\r\n' < "$KEY_FILE")"
elif [ -n "$NEXUS_API_KEY" ]; then
    KEY="$NEXUS_API_KEY"
fi

if [ -z "$KEY" ]; then
    echo "No Nexus API key found." >&2
    echo "  Save your free Personal API Key (one line) to: $KEY_FILE" >&2
    echo "  or set NEXUS_API_KEY. Get a key: https://www.nexusmods.com/users/myaccount?tab=api" >&2
    exit 1
fi

JQ="$(command -v jq || true)"
API="https://api.nexusmods.com/v1"
req() { curl -s -H "apikey: $KEY" -H "Accept: application/json" "$API$1"; }

case "${1:-}" in
    validate)
        if [ -n "$JQ" ]; then req "/users/validate.json" | "$JQ" '{name, user_id, is_premium}'
        else req "/users/validate.json"; fi
        ;;
    mod)
        ID="${2:?usage: nexus.sh mod <mod_id> [game_domain]}"
        DOMAIN="${3:-skyrimspecialedition}"
        if [ -n "$JQ" ]; then req "/games/$DOMAIN/mods/$ID.json" | "$JQ" '{name, version, updated_time, author, summary}'
        else req "/games/$DOMAIN/mods/$ID.json"; fi
        ;;
    raw)
        req "${2:?usage: nexus.sh raw <api_path, e.g. /games/skyrimspecialedition/mods/176043.json>}"
        ;;
    *)
        echo "Usage:" >&2
        echo "  bash tools/nexus.sh mod <mod_id> [game_domain]" >&2
        echo "  bash tools/nexus.sh validate" >&2
        echo "  bash tools/nexus.sh raw <api_path>" >&2
        exit 2
        ;;
esac

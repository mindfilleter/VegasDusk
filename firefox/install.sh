#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Standard Firefox configuration paths (Flatpak & Native, XDG & Legacy)
CONFIG_DIRS=(
  "$HOME/.var/app/org.mozilla.firefox/config/mozilla/firefox"
  "$HOME/.var/app/org.mozilla.firefox/.mozilla/firefox"
  "$HOME/.config/mozilla/firefox"
  "$HOME/.mozilla/firefox"
)

CACHE_DIRS=(
  "$HOME/.var/app/org.mozilla.firefox/cache/mozilla/firefox"
  "$HOME/.cache/mozilla/firefox"
)

# Collect existing config directories
EXISTING_DIRS=()
for dir in "${CONFIG_DIRS[@]}"; do
  [[ -d "$dir" ]] && EXISTING_DIRS+=("$dir")
done

if [[ ${#EXISTING_DIRS[@]} -eq 0 ]]; then
  echo "Error: No Firefox configuration directories found." >&2
  exit 1
fi

# Find all initialized profiles by locating prefs.js inside config directories
# Using -mindepth 1 and -maxdepth 2 to avoid finding profiles in unexpected places
mapfile -t PROFILES < <(find "${EXISTING_DIRS[@]}" -maxdepth 2 -name "prefs.js" -printf "%h\n" 2>/dev/null)

if [[ ${#PROFILES[@]} -eq 0 ]]; then
  echo "Error: No initialized Firefox profiles found." >&2
  exit 1
fi

# Close running Firefox instances so prefs are not overwritten on exit
if command -v flatpak >/dev/null 2>&1 && flatpak info org.mozilla.firefox >/dev/null 2>&1; then
  flatpak kill org.mozilla.firefox 2>/dev/null || true
fi
pkill -f firefox 2>/dev/null || true

set_user_pref() {
  local file="$1"
  local key="$2"
  local val="$3"
  touch "$file"
  if grep -q "\"$key\"" "$file" 2>/dev/null; then
    sed -i "s|user_pref(\"$key\",.*);|user_pref(\"$key\", $val);|" "$file"
  else
    echo "user_pref(\"$key\", $val);" >> "$file"
  fi
}

for FF_PROFILE in "${PROFILES[@]}"; do
  PROFILE_NAME="$(basename "$FF_PROFILE")"
  mkdir -p "$FF_PROFILE/chrome"

  # Clear matching startupCache so stylesheet changes apply immediately
  for cache_base in "${CACHE_DIRS[@]}"; do
    if [[ -d "$cache_base/$PROFILE_NAME/startupCache" ]]; then
      rm -rf "$cache_base/$PROFILE_NAME/startupCache"
    fi
  done

  # Enable custom stylesheets and set the Dark base theme non-destructively
  set_user_pref "$FF_PROFILE/user.js" "toolkit.legacyUserProfileCustomizations.stylesheets" "true"
  set_user_pref "$FF_PROFILE/user.js" "extensions.activeThemeID" "\"firefox-compact-dark@mozilla.org\""

  # Copy userChrome.css and userContent.css using cp -f (required for Flatpak)
  cp -f "$SCRIPT_DIR/userChrome.css" "$FF_PROFILE/chrome/userChrome.css"
  cp -f "$SCRIPT_DIR/userContent.css" "$FF_PROFILE/chrome/userContent.css"

  echo "Installed Vegas Dusk to: $FF_PROFILE/chrome"
done

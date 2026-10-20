#!/usr/env bin bash
# Locate the active Flatpak Firefox profile directory
FF_PROFILE=$(find ~/.var/app/org.mozilla.firefox/.mozilla/firefox -maxdepth 1 -type d -name "*.default-release" | head -n 1)

if [ -z "$FF_PROFILE" ]; then
  echo "Error: Could not find a .default-release profile in ~/.var/app/org.mozilla.firefox/"
  exit 1
fi

mkdir -p "$FF_PROFILE/chrome"

# Enable custom stylesheets automatically on startup
if ! grep -q "toolkit.legacyUserProfileCustomizations.stylesheets" "$FF_PROFILE/user.js" 2>/dev/null; then
  echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> "$FF_PROFILE/user.js"
fi

# Write userChrome.css
cat << 'EOF' > "$FF_PROFILE/chrome/userChrome.css"
:root {
  /* Frame & Tab Bar */
  --lwt-accent-color: #100812 !important;
  --lwt-accent-color-inactive: #170D1B !important;
  --lwt-text-color: #A3998A !important;

  /* Active Tab */
  --tab-selected-bgcolor: #241930 !important;
  --tab-selected-textcolor: #CAC2B6 !important;
  --tab-line-color: #D6AF4B !important;
  --lwt-tab-line-color: #D6AF4B !important;
  --tab-loading-fill: #D6AF4B !important;

  /* Navigation Toolbar */
  --toolbar-bgcolor: #241930 !important;
  --toolbar-color: #CAC2B6 !important;
  --lwt-toolbar-field-icon-fill: #A3998A !important;
  --toolbarbutton-icon-fill: #A3998A !important;
  --toolbarbutton-icon-fill-attention: #D6AF4B !important;
  --toolbarbutton-hover-background: #27234A !important;
  --toolbarbutton-active-background: #34254A !important;
  --chrome-content-separator-color: #3A2D4C !important;

  /* URL Bar / Search Field */
  --toolbar-field-background-color: #170D1B !important;
  --toolbar-field-color: #CAC2B6 !important;
  --toolbar-field-border-color: #3A2D4C !important;
  --toolbar-field-focus-background-color: #1F1D43 !important;
  --toolbar-field-focus-color: #CAC2B6 !important;
  --toolbar-field-focus-border-color: #D6AF4B !important;
  --focus-outline-color: #D6AF4B !important;
  --lwt-toolbar-field-highlight: #34254A !important;
  --lwt-toolbar-field-highlight-text: #CAC2B6 !important;

  /* Popups & Menus */
  --arrowpanel-background: #241930 !important;
  --arrowpanel-color: #CAC2B6 !important;
  --arrowpanel-border-color: #3A2D4C !important;
  --panel-item-hover-bgcolor: #27234A !important;
  --panel-item-active-bgcolor: #34254A !important;
  --autocomplete-popup-highlight-background: #27234A !important;
  --autocomplete-popup-highlight-color: #D6AF4B !important;

  /* Sidebar */
  --lwt-sidebar-background-color: #170D1B !important;
  --lwt-sidebar-text-color: #CAC2B6 !important;
  --sidebar-border-color: #3A2D4C !important;
}

/* Solid active tab with 1px border instead of drop-shadow gradient */
.tab-background:is([selected], [multiselected]) {
  background-color: #241930 !important;
  background-image: none !important;
  box-shadow: none !important;
  outline: 1px solid #3A2D4C !important;
}
EOF

# Write userContent.css
cat << 'EOF' > "$FF_PROFILE/chrome/userContent.css"
@-moz-document url("about:newtab"), url("about:home"), url("about:blank") {
  :root {
    --newtab-background-color: #100812 !important;
    --newtab-background-color-secondary: #241930 !important;
    --newtab-text-primary-color: #CAC2B6 !important;
    --newtab-text-secondary-color: #A3998A !important;
    --newtab-primary-action-background: #D6AF4B !important;
  }

  body {
    background-color: #100812 !important;
    color: #CAC2B6 !important;
  }
}
EOF

echo "Installed Vegas Dusk to: $FF_PROFILE/chrome"

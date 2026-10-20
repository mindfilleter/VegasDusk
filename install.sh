#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  --emacs            Install Emacs theme"
    echo "  --cosmic-term      Show instructions for COSMIC Terminal"
    echo "  --cosmic-desktop   Apply COSMIC Desktop settings and show instructions"
    echo "  --firefox          Install Firefox theme"
    echo "  --all              Install/apply all themes"
    exit 1
}

if [[ $# -eq 0 ]]; then
    usage
fi

DO_EMACS=false
DO_COSMIC_TERM=false
DO_COSMIC_DESKTOP=false
DO_FIREFOX=false

for arg in "$@"; do
    case $arg in
        --emacs)
            DO_EMACS=true
            ;;
        --cosmic-term)
            DO_COSMIC_TERM=true
            ;;
        --cosmic-desktop)
            DO_COSMIC_DESKTOP=true
            ;;
        --firefox)
            DO_FIREFOX=true
            ;;
        --all)
            DO_EMACS=true
            DO_COSMIC_TERM=true
            DO_COSMIC_DESKTOP=true
            DO_FIREFOX=true
            ;;
        *)
            echo "Unknown option: $arg"
            usage
            ;;
    esac
done

if [[ "$DO_EMACS" == true ]]; then
    echo "Installing Emacs theme..."
    mkdir -p "$HOME/.emacs.d/themes"
    ln -sf "$SCRIPT_DIR/emacs/vegas-dusk-theme.el" "$HOME/.emacs.d/themes/vegas-dusk-theme.el"
    echo "  -> Symlinked to $HOME/.emacs.d/themes/vegas-dusk-theme.el"
fi

if [[ "$DO_FIREFOX" == true ]]; then
    echo "Installing Firefox theme..."
    bash "$SCRIPT_DIR/firefox/install.sh"
fi

if [[ "$DO_COSMIC_TERM" == true ]]; then
    echo "COSMIC Terminal theme installation:"
    echo "  The configuration file is an import bundle. Do not copy it directly to color_schemes."
    echo "  Please import the following file via cosmic-settings or the COSMIC Terminal GUI:"
    echo "  -> $SCRIPT_DIR/cosmic-terminal/vegas-dusk.ron"
fi

if [[ "$DO_COSMIC_DESKTOP" == true ]]; then
    echo "Applying COSMIC Desktop settings..."
    mkdir -p "$XDG_CONFIG_HOME/cosmic/com.system76.CosmicTheme.Mode/v1"
    mkdir -p "$XDG_CONFIG_HOME/cosmic/com.system76.CosmicTk/v1"
    
    echo "true" > "$XDG_CONFIG_HOME/cosmic/com.system76.CosmicTheme.Mode/v1/is_dark"
    echo "true" > "$XDG_CONFIG_HOME/cosmic/com.system76.CosmicTk/v1/apply_theme_global"
    
    echo "  -> Enabled dark mode and global GTK/Icon theming."
    echo "  Please import the following file via cosmic-settings (Desktop -> Appearance):"
    echo "  -> $SCRIPT_DIR/cosmic-desktop/vegas-dusk-desktop.ron"
fi

echo "Done."

#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../common/functions.sh

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~/.config)"

info "Setting up Karabiner..."

substep_info "Creating config folder..."
mkdir -p "$DESTINATION"

substep_info "Creating karabiner folder symlink..."
symlink "$SOURCE" "$DESTINATION/karabiner"

success "Finished setting up Karabiner."
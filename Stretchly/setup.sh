#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../common/functions.sh

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~/Library/Application\ Support/Stretchly)"

info "Setting up Stretchly..."

substep_info "Creating Stretchly folder..."
mkdir -p "$DESTINATION"

find * -maxdepth 0 -name "*.json" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

success "Finished setting up Stretchly."
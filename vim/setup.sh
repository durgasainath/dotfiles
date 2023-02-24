#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../common/functions.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~)"

info "Setting up Vim..."

mkdir -p "$DESTINATION/.vim/.backup/"
mkdir -p "$DESTINATION/.vim/.swp/"
mkdir -p "$DESTINATION/.vim/.undo/"

find . -name ".vim*" | while read fn; do
    fn=$(basename $fn)
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

success "Finished setting up Vim."

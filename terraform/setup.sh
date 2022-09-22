#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../common/functions.sh

SOURCE="$(realpath -m .)"
DESTINATION="$(realpath -m ~)"

info "Setting up Terraform..."
mkdir -p "$HOME/.terraform.d/plugin-cache"

find . -name ".terraform*" | while read fn; do
    fn=$(basename $fn)
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

success "Finished setting up Terraform."
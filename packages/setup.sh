#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../common/functions.sh

info "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
success "Finished installing Homebrew."

info "Installing Brewfile packages..."
brew bundle
success "Finished installing Brewfile packages."

info "Installing Oh My Zsh..."
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
success "Finished installing Oh My Zsh."
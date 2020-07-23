#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../common/functions.sh

extnlist=(
vscoss.vscode-ansible
hookyqr.beautify
coenraads.bracket-pair-colorizer
formulahendry.code-runner
streetsidesoftware.code-spell-checker
kamikillerto.vscode-colorize
msjsdiag.debugger-for-chrome
ms-azuretools.vscode-docker
ria.elastic
eamodio.gitlens
golang.go
hashicorp.terraform
ms-kubernetes-tools.vscode-kubernetes-tools
redhat.java
esbenp.prettier-vscode
ms-python.python
mechatroner.rainbow-csv
chrmarti.regex
ms-vscode-remote.remote-containers
splunk.splunk
visualstudioexptteam.vscodeintellicode
redhat.vscode-xml
redhat.vscode-yaml
)

info "Setting Visual Studio Code..."

for extn in ${extnlist[@]}; do
	code --install-extension $extn
done

success "Finished setting up Visual Studio Code."
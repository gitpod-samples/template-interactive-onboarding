#!/usr/bin/env bash

# Install gum CLI
if ! command -v gum 1>/dev/null; then {
	echo "Installing gum"
	{
		echo 'deb [trusted=yes] https://repo.charm.sh/apt/ /' | sudo tee /etc/apt/sources.list.d/charm.list
		sudo apt update && sudo apt install gum
	} >/dev/null 2>&1
} fi


TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")
echo "You selected $TYPE";

SCOPE=$(gum input --placeholder "scope")
echo "You entered $SCOPE"
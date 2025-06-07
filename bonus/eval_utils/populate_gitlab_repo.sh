#!/bin/bash

CLONE_REPO_URL="https://github.com/ltouret/ltouret-iot-part-3-config.git"
LOCAL_REPO_DIR=$(mktemp -d)

NEW_REMOTE_NAME="gitlab-remote"
NEW_REMOTE_URL="git@gitlab.iot.local:root/ltouret-argocd.git"

BRANCH_TO_PUSH="main"

echo "Add this ssh key to gitlab.."
rm -f ~/.ssh/id_ed25519.pub ~/.ssh/id_ed25519
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N '' -C "bestvmever@iot.local"
echo -e "\e[41m\e[5mPlease copy this ssh key in the Gitlab UI at gitlab.iot.local :\e[0m"
cat ~/.ssh/id_ed25519.pub

read -p "Type 'y' and enter to proceed: " confirmation

echo -e "\e[41m\e[5mAre you sure ?\e[0m"
read -p "Type 'y' and enter to proceed: " confirmation

if [ "$confirmation" != "y" ]
then
	echo "Operation cancelled. Try again!"
	exit 11
fi
echo "Starting Git operations..."

git clone "$CLONE_REPO_URL" "$LOCAL_REPO_DIR"
cd "$LOCAL_REPO_DIR" || cd "."

echo "Adding new remote: $NEW_REMOTE_NAME with URL $NEW_REMOTE_URL..."
git remote add "$NEW_REMOTE_NAME" "$NEW_REMOTE_URL"

echo "Pushing $BRANCH_TO_PUSH branch to the new remote '$NEW_REMOTE_NAME'..."
ssh-keyscan gitlab.iot.local >> ~/.ssh/known_hosts
git push -u "$NEW_REMOTE_NAME" "$BRANCH_TO_PUSH"

echo "Gitlab repo was successfully populated."

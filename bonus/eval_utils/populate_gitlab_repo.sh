#!/bin/bash

CLONE_REPO_URL="https://github.com/ltouret/ltouret-iot-part-3-config.git"
LOCAL_REPO_DIR=$(mktemp -d)
# delete after?

NEW_REMOTE_NAME="gitlab-remote"
NEW_REMOTE_URL="git@gitlab.iot.local:root/ltouret-argocd.git"

BRANCH_TO_PUSH="main"

echo "Starting Git operations..."

git clone "$CLONE_REPO_URL" "$LOCAL_REPO_DIR"
cd "$LOCAL_REPO_DIR" || cd "."

echo "Adding or updating new remote: $NEW_REMOTE_NAME with URL $NEW_REMOTE_URL..."
git remote add "$NEW_REMOTE_NAME" "$NEW_REMOTE_URL" || git remote set-url "$NEW_REMOTE_NAME" "$NEW_REMOTE_URL"

echo "Pulling latest changes from existing 'origin' remote (if applicable)..."
git pull origin "$BRANCH_TO_PUSH"

echo "Pushing $BRANCH_TO_PUSH branch to the new remote '$NEW_REMOTE_NAME'..."
git push -u "$NEW_REMOTE_NAME" "$BRANCH_TO_PUSH"

echo "Git operations completed."
echo "Current remotes:"
git remote -v

#!/bin/bash
set -e  # exit immediately if a command exits with a non-zero status

echo "Changing directory to the backend..."
cd /root/server/lexomat/backend/ || { echo "Directory not found"; exit 1; }

echo "Pulling latest code from origin main..."
git pull origin main

# If uv is installed in $HOME/.local/bin on your VPS, add it to PATH.
echo "Updating PATH to include local binaries..."
export PATH="$HOME/.local/bin:$PATH"

echo "Syncing project environment using uv..."
uv sync

echo "Restarting FastAPI via supervisor..."
sudo supervisorctl restart lexomat

echo "Deployment complete."

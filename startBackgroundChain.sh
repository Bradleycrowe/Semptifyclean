#!/bin/bash
echo "👀 Watching for changes..."

while true; do
  CHANGES=$(git status --porcelain)

  if [ ! -z "$CHANGES" ]; then
    echo "🔄 Change detected. Running full chain..."
    ./runCopilotSync.sh
    ./macros/runVaultUpload.sh
    git add .
    git commit -m "auto: synced Copilots and uploaded Vault"
    git push origin main
    echo "✅ Chain complete. Waiting for next change..."
  fi

  sleep 30
done

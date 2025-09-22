#!/bin/bash
# autoSyncLoop.sh — Watches for changes and runs sync

echo "👀 Watching for changes..."

while true; do
  CHANGES=$(git status --porcelain)

  if [ ! -z "$CHANGES" ]; then
    echo "🔄 Change detected. Running sync..."
    ./runCopilotSync.sh
    git add .
    git commit -m "auto: synced Copilots"
    git push origin main
  fi

  sleep 30
done

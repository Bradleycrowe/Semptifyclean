#!/bin/bash
echo "🔄 Syncing Copilots..."
./runCopilotSync.sh

echo "🚀 Running Vault Upload..."
./macros/runVaultUpload.sh

echo "📤 Committing to GitHub..."
git add .
git commit -m "auto: synced Copilots and uploaded Vault"
git push origin main

echo "✅ All done."

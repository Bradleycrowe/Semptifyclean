# Semptify Automation System

This system automates collaboration between Copilots using background sync, Vault uploads, and Git commits.

## Structure
- `upload-flow/` — Copilot A's output
- `retrieval-flow/` — Copilot B's output
- `macros/` — Upload and sync scripts
- `logs/` — Status, conflicts, and upload logs

## Scripts
- `runCopilotSync.sh` — Logs changes and detects conflicts
- `macros/runVaultUpload.sh` — Uploads files to Vault
- `runAll.sh` — Runs sync + upload + commit
- `startBackgroundChain.sh` — Watches for changes and runs full chain
- `stopChain.sh` — Stops background watcher

## Usage
```bash
./runAll.sh              # Manual one-click sync
./startBackgroundChain.sh &  # Start automation loop
./stopChain.sh           # Stop automation loop
```

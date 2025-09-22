#!/bin/bash
# buildSemptify.sh — One-click setup for full Semptify system

echo "🚧 Setting up Semptify workspace..."

# Create folders and logs
mkdir -p upload-flow retrieval-flow macros logs docs
touch logs/status.txt logs/conflicts.txt

# Create runCopilotSync.sh
cat << 'EOF' > runCopilotSync.sh
#!/bin/bash
LOG_FILE="logs/status.txt"
CONFLICT_FILE="logs/conflicts.txt"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

git diff --name-only HEAD~1 upload-flow/ > temp_upload.txt
git diff --name-only HEAD~1 retrieval-flow/ > temp_retrieval.txt

if [ -s temp_upload.txt ]; then
  while read -r file; do
    echo "$DATE Copilot A Modified $file" >> "$LOG_FILE"
  done < temp_upload.txt
fi

if [ -s temp_retrieval.txt ]; then
  while read -r file; do
    echo "$DATE Copilot B Modified $file" >> "$LOG_FILE"
  done < temp_retrieval.txt
fi

comm -12 <(sort temp_upload.txt) <(sort temp_retrieval.txt) > temp_conflicts.txt
if [ -s temp_conflicts.txt ]; then
  echo "$DATE Conflict detected:" >> "$CONFLICT_FILE"
  cat temp_conflicts.txt >> "$CONFLICT_FILE"
fi

rm temp_upload.txt temp_retrieval.txt temp_conflicts.txt
EOF
chmod +x runCopilotSync.sh

# Create runVaultUpload.sh
cat << 'EOF' > macros/runVaultUpload.sh
#!/bin/bash
echo "📦 Uploading Vault files..."
for file in upload-flow/*; do
  [ -f "$file" ] || continue
  echo "Uploading $file..."
  curl -X POST http://localhost:3000/upload \
       -F "file=@$file" \
       -H "Authorization: Bearer your_token_here"
done
echo "✅ Vault upload complete."
EOF
chmod +x macros/runVaultUpload.sh

# Create runAll.sh
cat << 'EOF' > runAll.sh
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
EOF
chmod +x runAll.sh

# Create background watcher
cat << 'EOF' > startBackgroundChain.sh
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
EOF
chmod +x startBackgroundChain.sh

echo "🚀 Semptify system is ready. Run this to start background automation:"
echo "./startBackgroundChain.sh &"

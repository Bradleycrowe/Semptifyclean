#!/bin/bash
# runCopilotSync.sh — One-click sync for both Copilots

echo "🔄 Syncing Copilot outputs..."

# Step 1: Create folders and logs if missing
mkdir -p upload-flow retrieval-flow macros logs docs
touch logs/status.txt logs/conflicts.txt

# Step 2: Check for recent changes
git diff --name-only HEAD~1 upload-flow/ > temp_upload.txt
git diff --name-only HEAD~1 retrieval-flow/ > temp_retrieval.txt

# Step 3: Log Copilot actions
DATE=$(date '+%Y-%m-%d %H:%M:%S')
if [ -s temp_upload.txt ]; then
  while read -r file; do
    echo "$DATE Copilot A Modified $file" >> logs/status.txt
  done < temp_upload.txt
fi

if [ -s temp_retrieval.txt ]; then
  while read -r file; do
    echo "$DATE Copilot B Modified $file" >> logs/status.txt
  done < temp_retrieval.txt
fi

# Step 4: Flag conflicts
comm -12 <(sort temp_upload.txt) <(sort temp_retrieval.txt) > temp_conflicts.txt
if [ -s temp_conflicts.txt ]; then
  echo "$DATE Conflict detected:" >> logs/conflicts.txt
  cat temp_conflicts.txt >> logs/conflicts.txt
  echo "⚠️ Conflicts logged."
else
  echo "✅ No conflicts detected."
fi

# Step 5: Cleanup
rm temp_upload.txt temp_retrieval.txt temp_conflicts.txt

echo "✅ Copilot sync complete. Logs updated."

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

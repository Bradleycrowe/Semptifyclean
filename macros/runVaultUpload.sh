#!/bin/bash
echo "📦 Uploading Vault files..."
DATE=$(date '+%Y-%m-%d %H:%M:%S')
for file in upload-flow/*; do
  [ -f "$file" ] || continue
  echo "$DATE Uploading $file..." >> logs/upload.log
  curl -X POST http://localhost:3000/upload \
       -F "file=@$file" \
       -H "Authorization: Bearer your_token_here"
done
echo "$DATE ✅ Vault upload complete." >> logs/upload.log

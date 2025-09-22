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

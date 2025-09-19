# Find the most recent log file
$latestLog = Get-ChildItem -Path . -Filter "server_log_*.txt" | Sort-Object LastWriteTime -Descending | Select-Object -First 1

# Read contents and copy to clipboard
if ($latestLog) {
    Get-Content $latestLog.FullName | Set-Clipboard
    Write-Host "✅ Copied contents of $($latestLog.Name) to clipboard. Paste it into chat with Ctrl + V."
} else {
    Write-Host "⚠️ No log files found."
}

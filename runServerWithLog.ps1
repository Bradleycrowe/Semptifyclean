$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$logFile = "server_log_$timestamp.txt"

Write-Host "Starting Semptify backend..." | Tee-Object -FilePath $logFile
node server/index.js 2>&1 | Tee-Object -FilePath $logFile -Append

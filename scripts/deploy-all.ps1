# Kill anything on port 3000
try {
  $pid = (Get-NetTCPConnection -LocalPort 3000).OwningProcess
  Stop-Process -Id $pid -Force
  Write-Host "✅ Port 3000 cleared"
} catch {
  Write-Host "ℹ️ Port 3000 was already free"
}

# Log start
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$log = "$timestamp - Starting full deployment"
Add-Content -Path "$PSScriptRoot\..\logs\master-log.txt" -Value $log

# Launch client and server
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot\..\client'; npm start"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot\..\server'; node server.js"

# Log launch
$log = "$timestamp - Client and server launched"
Add-Content -Path "$PSScriptRoot\..\logs\master-log.txt" -Value $log
$log | Set-Clipboard

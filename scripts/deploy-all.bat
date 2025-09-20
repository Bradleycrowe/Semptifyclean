@echo off
echo Killing port 3000...

for /f "tokens=5" %%a in ('netstat -aon ^| find ":3000" ^| find "LISTENING"') do (
    taskkill /PID %%a /F
    echo ✅ Port 3000 cleared
)

echo Launching Semptify client and server...

start cmd /k "cd /d %~dp0..\client && npm start"
start cmd /k "cd /d %~dp0..\server && node server.js"

echo Deployment logged.

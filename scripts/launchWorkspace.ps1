# Go to SemptifyClean folder
cd "C:\Users\bradc\Desktop\aaa Brads Repos\SemptifyClean"

# Create folders
mkdir letters, scripts, logs, templates, docs, server\routes, client\src\screens -Force

# Create and fill README.md
@'
# SemptifyClean

SemptifyClean is a modular workspace for tenant justice and legal empowerment.  
Built for non-coders, slow typers, and organizers who need repeatable tools.

## Structure
- letters/: Certified mail drafts and templates
- scripts/: PowerShell tools for automation and logging
- logs/: Master log of actions and outcomes
- templates/: Reusable letter formats
- docs/: Technical guides and onboarding
'@ | Set-Content README.md

# Create and fill master-log.md
@'
# SemptifyClean — Master Log

## 📅 September 2025

### ✅ 09/18 — Workspace Launch
- Created folders and scaffolded key files
- Connected repo to GitHub
- Added backend route and frontend screen
'@ | Set-Content logs\master-log.md

# Create and fill copilot_instructions.md
@'
# Semptify — Copilot Instructions (Short)

## Run & Debug
- Backend: `node server/index.js`
- Frontend: `cd client && npm start`

## Structure
- Frontend: React in `client/src/screens/`
- Backend: Express in `server/index.js`
- Logging: Use PowerShell scripts to capture output
'@ | Set-Content docs\copilot_instructions.md

# Create and fill backend route
@'
const express = require('express');
const router = express.Router();

router.get('/status', (req, res) => {
  res.json({ status: "Semptify backend is alive", timestamp: new Date().toISOString() });
});

module.exports = router;
'@ | Set-Content server\routes\statusRoute.js

# Create and fill frontend screen
@'
import React from "react";

function StatusScreen() {
  return (
    <div style={{ padding: 20 }}>
      <h2>Backend Status</h2>
      <p>Check the backend connection at <code>/api/status</code>.</p>
    </div>
  );
}

export default StatusScreen;
'@ | Set-Content client\src\screens\StatusScreen.js

# Open key files in VS Code
code README.md
code logs\master-log.md
code docs\copilot_instructions.md
code server\routes\statusRoute.js
code client\src\screens\StatusScreen.js

# Confirm setup
Write-Host "Workspace launched. Files scaffolded and opened." -ForegroundColor Green

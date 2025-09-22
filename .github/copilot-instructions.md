<!--
Concise guidance for AI coding agents working on SemptifyClean.
Focus: run/debug commands, repository patterns, and where to make low-risk changes.
-->

# Semptify — Copilot instructions (short)

Overview
- Frontend: React (Create React App) in `client/`. Entry: `client/src/index.js`. Main UI: `client/src/App.js` and `client/src/screens/*`.
- Backend: Node + Express in `server/`. Entry: `server/index.js`. Very small — one GET / route and basic middleware.

Run & debug (Windows PowerShell)
- Backend (simple):
  ```powershell
  <!--
  Semptify — concise Copilot instructions
  Purpose: give an AI coding agent the minimum, accurate facts to be productive in this repo.
  Keep this short (20–50 lines); update when file layout or run commands change.
  -->

  # Quick facts
  - Frontend: React (Create React App) in `client/`. App entry: `client/src/index.js`. Main UI lives in `client/src/App.js`.
  - Backend: Node + Express in `server/`. Actual entry: `server/server.js` (not `index.js`).

  # Run / debug (Windows PowerShell)
  - Start backend (simple):
    - node server/server.js
  - Start backend and capture logs (recommended):
    - .\runServerWithLog.ps1  # writes timestamped server_log_YYYY-MM-DD_HH-mm-ss.txt
  - Frontend (first-time):
    - cd client
    - npm install
    - npm start
    - client `package.json` sets a proxy to `http://localhost:3001` so requests to `/verify`, `/vault/*`, etc. go to the server.

  # Project-specific conventions
  - API routes live in `server/`; small app currently implements routes in `server/server.js` (verify, /home, /rights/*, /letters, /vault/*).
  - File uploads use `multer` and are stored in `server/uploads/` with timestamped filenames (see `server/server.js`).
  - UI is screen-based; add new screens under `client/src/screens/` and wire them into `client/src/App.js` routes.
  - Logging: use the provided PowerShell scripts in the repo root or `scripts/` to capture reproducible logs.

  # Where to touch safely (low-risk change ideas)
  - Add a new API route: create `server/routes/<name>.js`, export a router, and mount it in `server/server.js`.
  - Add a new screen: `client/src/screens/NewScreen.js` and add a <Route> in `client/src/App.js`.
  - Add tests or types cautiously; the repo has no test runner configured beyond CRA client tests.

  # Integration notes & gotchas
  - Server entry in `package.json` incorrectly points to `index.js`; the real file is `server.js` — prefer calling `node server/server.js`.
  - The frontend proxy in `client/package.json` expects the backend on port 3001 (see `server/server.js`).
  - No environment variable configuration is present. If adding secrets or configs, add `server/config/` and document env vars at repo root.

  # PR checklist (specific)
  - Explain why change is needed and which files changed.
  - List exact manual validation steps (start server with log, start client, hit `/verify`, exercise affected UI screens).
  - Include the `server_log_*.txt` file when backend behavior is modified.

  If anything in these instructions is unclear or you want more detail (example route+controller patch, CI, or tests), tell me which area to expand.

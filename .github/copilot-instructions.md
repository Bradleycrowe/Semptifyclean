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
  node server/index.js
  ```
- Backend with timestamped logs (recommended when changing server behavior):
  ```powershell
  .\runServerWithLog.ps1
  # or from server/: .\server\runServerWithLog.ps1
  ```
- Frontend (CRA):
  ```powershell
  cd client
  npm install   # first-time only
  npm start
  ```

Project-specific patterns
- UI: Minimal, file-per-component screens in `client/src/screens/`. Components use inline style objects (see `App.js`, `HomeScreen.js`).
- Backend: Keep route handlers under `server/routes/`, logic in `server/controllers/`, and data shapes in `server/models/` when you add features — current code keeps everything in `server/index.js`.
- Logging: Use provided PS scripts to capture stdout/stderr into `server_log_YYYY-MM-DD_HH-mm-ss.txt` for reproducible debugging.

Integration and dependencies
- No external services are configured yet (comments mention planned Firebase). If you add integrations, create `server/config/` and document required env vars at repo root.
- Key dependencies: backend -> `express`, `cors`; frontend -> `react`, `react-dom`, `react-scripts` (see each `package.json`).

Where to change things (examples)
- Add an API route: create `server/routes/myRoute.js` and a controller `server/controllers/myRouteController.js`, then require/mount it in `server/index.js`.
- Add UI screen: add `client/src/screens/NewScreen.js` and import it in `client/src/App.js`.

PR checklist (short)
- Describe the change and reason.
- List manual steps to validate (commands above). Attach a `server_log_*.txt` if backend changed.
- If new packages added, update lockfiles and note install commands.

If you want this expanded (example route+controller patch, unit tests, or CI), tell me which part to add and I will produce it.

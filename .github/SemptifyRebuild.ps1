# Kill any running Node processes
Stop-Process -Name node -Force -ErrorAction SilentlyContinue

# Set working directory
$base = "C:\Users\bradc\Desktop\aaa Brads Repos\SemptifyClean"
Set-Location $base

# Delete old folders
Remove-Item -Recurse -Force "$base\client" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$base\server" -ErrorAction SilentlyContinue

# Rebuild backend
mkdir server
Set-Location "$base\server"
npm init -y
npm install express

@"
const express = require('express');
const app = express();
app.use(express.json());

app.get('/home', (req, res) => {
  res.json({ welcome: 'Welcome to Semptify' });
});
app.get('/rights', (req, res) => {
  res.json({ message: 'Rights Navigator route active' });
});
app.get('/vault/files', (req, res) => {
  res.json({ files: [] });
});
app.post('/letters', (req, res) => {
  res.json({ message: 'Letter of type ' + req.body.type + ' generated' });
});
app.listen(3001, () => {
  console.log('Server running on port 3001');
});
"@ | Set-Content "server.js"

# Launch backend
Start-Process powershell -ArgumentList "node server.js" -WorkingDirectory "$base\server"

# Rebuild frontend
Set-Location $base
npx create-react-app client
Set-Location "$base\client"
npm install react-router-dom

# Inject proxy
(Get-Content "package.json") -replace '"name": ".*?",', '"name": "semptify-client", "proxy": "http://localhost:3001",' | Set-Content "package.json"

# Overwrite App.js
@"
import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';

function Home() {
  const [message, setMessage] = useState('');
  useEffect(() => {
    fetch('/home')
      .then(res => res.json())
      .then(data => setMessage(data.welcome))
      .catch(() => setMessage('Failed to connect to backend'));
  }, []);
  return (
    <div style={{ padding: '2rem' }}>
      <h2>Home</h2>
      <p>{message}</p>
    </div>
  );
}

function Rights() {
  const [message, setMessage] = useState('');
  const [loading, setLoading] = useState(true);
  useEffect(() => {
    fetch('/rights')
      .then(res => res.json())
      .then(data => {
        setMessage(data.message);
        setLoading(false);
      })
      .catch(() => {
        setMessage('Failed to connect to backend');
        setLoading(false);
      });
  }, []);
  return (
    <div style={{ padding: '2rem' }}>
      <h2>Rights Navigator</h2>
      {loading ? <p>Loading...</p> : <p>{message}</p>}
      <div style={{ marginTop: '2rem' }}>
        <ul>
          <li>🏠 Lease & Rent</li>
          <li>🚪 Eviction & Entry</li>
          <li>🛠️ Repairs & Conditions</li>
          <li>📞 Retaliation & Harassment</li>
        </ul>
      </div>
    </div>
  );
}

function Vault() {
  const [files, setFiles] = useState([]);
  useEffect(() => {
    fetch('/vault/files')
      .then(res => res.json())
      .then(data => setFiles(data.files || []))
      .catch(() => setFiles([]));
  }, []);
  return (
    <div style={{ padding: '2rem' }}>
      <h2>Vault</h2>
      <p>Files: {files.length === 0 ? 'None' : files.join(', ')}</p>
    </div>
  );
}

function Letters() {
  const [response, setResponse] = useState('');
  const sendLetter = () => {
    fetch('/letters', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ type: 'Eviction', details: 'Urgent' })
    })
      .then(res => res.json())
      .then(data => setResponse(data.message))
      .catch(() => setResponse('Failed to send letter'));
  };
  return (
    <div style={{ padding: '2rem' }}>
      <h2>Letters</h2>
      <button onClick={sendLetter}>Generate Letter</button>
      <p>{response}</p>
    </div>
  );
}

function App() {
  return (
    <Router>
      <nav style={{ padding: '1rem', background: '#eee' }}>
        <Link to="/">Home</Link> | <Link to="/rights">Rights</Link> | <Link to="/vault">Vault</Link> | <Link to="/letters">Letters</Link>
      </nav>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/rights" element={<Rights />} />
        <Route path="/vault" element={<Vault />} />
        <Route path="/letters" element={<Letters />} />
      </Routes>
    </Router>
  );
}

export default App;
"@ | Set-Content "src\App.js"

# Launch frontend
Start-Process powershell -ArgumentList "npm start" -WorkingDirectory "$base\client"


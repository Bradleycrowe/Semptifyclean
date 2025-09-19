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

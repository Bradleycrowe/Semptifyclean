import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
import VaultUpload from './components/VaultUpload';

function Verifier() {
  const [status, setStatus] = useState('Checking...');
  useEffect(() => {
    fetch('/verify')
      .then(res => res.json())
      .then(data => {
        if (data.backend) {
          setStatus(`✅ System OK — ${new Date(data.timestamp).toLocaleString()}`);
        } else {
          setStatus('❌ Backend unreachable');
        }
      })
      .catch(() => setStatus('❌ Backend unreachable'));
  }, []);
  return <div style={{ padding: '1rem', fontSize: '0.9rem', color: '#555' }}>{status}</div>;
}

function Home() {
  const [message, setMessage] = useState('');
  useEffect(() => {
    fetch('/home')
      .then(res => res.json())
      .then(data => setMessage(data.welcome))
      .catch(() => setMessage('Failed to connect to backend'));
  }, []);
  return <div style={{ padding: '2rem' }}><h2>Home</h2><p>{message}</p></div>;
}

function Rights() {
  return (
    <div style={{ padding: '2rem' }}>
      <h2>Rights Navigator</h2>
      <ul>
        <li><Link to="/rights/lease">🏠 Lease & Rent</Link></li>
        <li><Link to="/rights/eviction">🚪 Eviction & Entry</Link></li>
        <li><Link to="/rights/repairs">🛠️ Repairs & Conditions</Link></li>
        <li><Link to="/rights/retaliation">📞 Retaliation & Harassment</Link></li>
      </ul>
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
  return <div style={{ padding: '2rem' }}><h2>Vault</h2><p>Files: {files.length === 0 ? 'None' : files.join(', ')}</p></div>;
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
  return <div style={{ padding: '2rem' }}><h2>Letters</h2><button onClick={sendLetter}>Generate Letter</button><p>{response}</p></div>;
}

function Lease() {
  const [message, setMessage] = useState('');
  useEffect(() => {
    fetch('/rights/lease')
      .then(res => res.json())
      .then(data => setMessage(data.message))
      .catch(() => setMessage('Failed to connect to backend'));
  }, []);
  return <div style={{ padding: '2rem' }}><h2>Lease & Rent</h2><p>{message}</p></div>;
}

function Eviction() {
  const [message, setMessage] = useState('');
  useEffect(() => {
    fetch('/rights/eviction')
      .then(res => res.json())
      .then(data => setMessage(data.message))
      .catch(() => setMessage('Failed to connect to backend'));
  }, []);
  return <div style={{ padding: '2rem' }}><h2>Eviction & Entry</h2><p>{message}</p></div>;
}

function Repairs() {
  const [message, setMessage] = useState('');
  useEffect(() => {
    fetch('/rights/repairs')
      .then(res => res.json())
      .then(data => setMessage(data.message))
      .catch(() => setMessage('Failed to connect to backend'));
  }, []);
  return <div style={{ padding: '2rem' }}><h2>Repairs & Conditions</h2><p>{message}</p></div>;
}

function Retaliation() {
  const [message, setMessage] = useState('');
  useEffect(() => {
    fetch('/rights/retaliation')
      .then(res => res.json())
      .then(data => setMessage(data.message))
      .catch(() => setMessage('Failed to connect to backend'));
  }, []);
  return <div style={{ padding: '2rem' }}><h2>Retaliation & Harassment</h2><p>{message}</p></div>;
}

function App() {
  return (
    <Router>
      <div style={{ padding: '1rem', background: '#eee' }}>
        <nav>
          <Link to="/">Home</Link> | <Link to="/rights">Rights</Link> | <Link to="/vault">Vault</Link> | <Link to="/letters">Letters</Link>
        </nav>
        <Verifier />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/rights" element={<Rights />} />
          <Route path="/vault" element={<Vault />} />
          <Route path="/letters" element={<Letters />} />
          <Route path="/rights/lease" element={<Lease />} />
          <Route path="/rights/eviction" element={<Eviction />} />
          <Route path="/rights/repairs" element={<Repairs />} />
          <Route path="/rights/retaliation" element={<Retaliation />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;

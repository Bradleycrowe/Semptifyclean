import React, { useState, useEffect } from 'react';

function VaultUpload() {
  const [file, setFile] = useState(null);
  const [message, setMessage] = useState('');
  const [files, setFiles] = useState([]);

  const handleFileChange = (e) => {
    setFile(e.target.files[0]);
  };

  const handleUpload = () => {
    if (!file) return setMessage('❌ No file selected');

    const formData = new FormData();
    formData.append('file', file);

    fetch('http://localhost:3001/vault/upload', {
      method: 'POST',
      body: formData,
    })
      .then(res => res.json())
      .then(data => {
        if (data.success) {
          setMessage('✅ File uploaded successfully');
          setFile(null);
          fetchFiles();
        } else {
          setMessage('❌ Upload failed');
        }
      })
      .catch(() => setMessage('❌ Server error'));
  };

  const fetchFiles = () => {
    fetch('http://localhost:3001/vault/files')
      .then(res => res.json())
      .then(data => setFiles(data.files || []));
  };

  useEffect(() => {
    fetchFiles();
  }, []);

  return (
    <div style={{ padding: '1rem' }}>
      <h2>Vault</h2>
      <input type="file" onChange={handleFileChange} />
      <button onClick={handleUpload} style={{ marginLeft: '1rem' }}>
        Upload
      </button>
      <p>{message}</p>
      <h3>Files:</h3>
      <ul>
        {files.length === 0 ? (
          <li>None</li>
        ) : (
          files.map((f, i) => <li key={i}>{f}</li>)
        )}
      </ul>
    </div>
  );
}

export default VaultUpload;

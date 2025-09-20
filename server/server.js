const express = require('express');
const cors = require('cors');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const app = express();
const PORT = 3001;

app.use(cors());
app.use(express.json());

// ✅ Logging middleware
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
  next();
});

// ✅ Ensure uploads folder exists
const uploadDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir);
}

// ✅ Multer setup
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, uploadDir),
  filename: (req, file, cb) => {
    const timestamp = Date.now();
    const safeName = file.originalname.replace(/\s+/g, '_');
    cb(null, `${timestamp}_${safeName}`);
  }
});
const upload = multer({ storage });

// ✅ Verifier route
app.get('/verify', (req, res) => {
  res.json({ status: 'OK', backend: true, timestamp: new Date().toISOString() });
});

// ✅ Home route
app.get('/home', (req, res) => {
  res.json({ welcome: 'Welcome to Semptify — your tenant justice toolkit.' });
});

// ✅ Letters route
app.post('/letters', (req, res) => {
  const { type, details } = req.body;
  console.log('Letter request body:', req.body);
  if (!type) {
    return res.status(400).json({ message: 'Missing letter type' });
  }
  res.json({ message: `Letter of type "${type}" received with details: "${details || 'none'}"` });
});

// ✅ Rights routes
app.get('/rights/lease', (req, res) => {
  res.json({ message: 'Lease & Rent rights are active.' });
});
app.get('/rights/eviction', (req, res) => {
  res.json({ message: 'Eviction & Entry rights are active.' });
});
app.get('/rights/repairs', (req, res) => {
  res.json({ message: 'Repairs & Conditions rights are active.' });
});
app.get('/rights/retaliation', (req, res) => {
  res.json({ message: 'Retaliation & Harassment rights are active.' });
});

// ✅ Vault route
app.get('/vault/files', (req, res) => {
  fs.readdir(uploadDir, (err, files) => {
    if (err) return res.status(500).json({ error: 'Failed to read vault' });
    res.json({ files });
  });
});

// ✅ Vault upload route
app.post('/vault/upload', upload.single('file'), (req, res) => {
  if (!req.file) return res.status(400).json({ message: 'No file uploaded' });
  console.log(`Uploaded: ${req.file.filename}`);
  res.json({ message: 'File uploaded successfully', filename: req.file.filename });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

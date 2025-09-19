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

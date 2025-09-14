const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.send('Semptify backend is live and ready.');
});

// Future: Firebase integration, complaint storage, user auth

app.listen(PORT, () => {
  console.log(`Semptify backend running on port ${PORT}`);
});

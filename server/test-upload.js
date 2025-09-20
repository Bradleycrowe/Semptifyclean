const fs = require('fs');
const path = require('path');
const FormData = require('form-data');
const axios = require('axios');

const form = new FormData();
form.append('file', fs.createReadStream(path.join(__dirname, 'test.txt')));

axios.post('http://localhost:3001/vault/upload', form, {
  headers: form.getHeaders(),
})
.then(res => console.log(res.data))
.catch(err => console.error(err.response?.data || err.message));

const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');

const users = require('./routes/users');
const admins = require('./routes/admins');

// APP CONFIG
const app = express();
const port = 3000;

// DATABASE CONFIG
const connection = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: '',
  database: 'flutter'
});

connection.connect();

// MIDDLEWARES
app.use(express.json());
app.use(bodyParser.json());

// CRUD LOGIN
app.post('/login', (req, res) => {
  const { useremail, password } = req.body;

  const query = `
    (SELECT 'usuario' AS tipo, id, nombre, email FROM usuarios WHERE email = ? AND password = ?)
    UNION
    (SELECT 'administrador' AS tipo, id, nombre, email FROM administradores WHERE email = ? AND password = ?)
  `;

  connection.query(query, [useremail, password, useremail, password], (error, results) => {
    if (error) {
      res.status(500).json({ success: false, message: 'Error en el servidor' });
    } else {
      if (results.length > 0) {
        const user = results[0];
        res.json({ success: true, user });
      } else {
        res.status(401).json({ success: false, message: 'Usuario o contraseña incorrectos' });
      }
    }
  });
});

// CRUD USERS
app.use('/users', users);
app.use('/admins', admins);



// PORT LISTEN
app.listen(port, () => {
  console.log(`Servidor backend escuchando en http://localhost:${port}`);
});
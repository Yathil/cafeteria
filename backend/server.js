const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const bcrypt = require('bcrypt');

const users = require('./routes/users');
const admins = require('./routes/admins');

// APP CONFIG
const app = express();
const port = 3000;

// DATABASE CONFIG
const pool = mysql.createPool({
  host: '127.0.0.1',
  user: 'root',
  password: '',
  database: 'flutter'
});

connection.connect();

// MIDDLEWARES
app.use(express.json());
app.use(bodyParser.json());

// ENDPOINTS
app.get('/', (req, res) => {
  res.send('Hello World!');
});


// ROUTES
app.use('/users', users);
app.use('/admins', admins);

// ERROR HANDLING
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Algo salió mal!');
});

// LOGIN
app.post('/login', async (req, res) => {
  const { useremail, password } = req.body;

  const query = `
    (SELECT 'usuario' AS tipo, id, nombre, email, password FROM usuarios WHERE email = ?)
    UNION
    (SELECT 'administrador' AS tipo, id, nombre, email, password FROM administradores WHERE email = ?)
  `;

  pool.query(query, [useremail, useremail], async (error, results) => {
    if (error) {
      res.status(500).json({ success: false, message: 'Error en el servidor' });
    } else {
      if (results.length > 0) {
        const user = results[0];

        // Comprueba si la contraseña proporcionada coincide con el hash almacenado
        const match = await bcrypt.compare(password, user.password);

        if (match) {
          // Elimina la contraseña del objeto de usuario antes de enviarlo
          delete user.password;
          res.json({ success: true, user });
        } else {
          res.status(401).json({ success: false, message: 'Usuario o contraseña incorrectos' });
        }
      } else {
        res.status(401).json({ success: false, message: 'Usuario o contraseña incorrectos' });
      }
    }
  });
});

// PORT LISTEN
app.listen(port, () => {
  console.log(`Servidor backend escuchando en http://localhost:${port}`);
});
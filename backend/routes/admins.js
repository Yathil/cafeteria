const mysql = require('mysql');
const bcrypt = require('bcrypt');
const saltRounds = 10;

//Metodo para crear un nuevo administrador
async function createAdmin(admin) {
  const conn = await connect();
  const query = 'INSERT INTO administradores (nombre, email, password) VALUES (?, ?, ?)';
  const values = [admin.nombre, admin.email, admin.password];

  return new Promise((resolve, reject) => {
    conn.query(query, values, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results.affectedRows > 0);
      }
      conn.end();
    });
  });
}

//Metodo para obtener un administrador por email y contraseña
async function getAdminByEmailAndPassword(email, password) {
  const conn = await connect();
  const query = 'SELECT * FROM administradores WHERE email = ? AND password = ?';
  const values = [email, password];

  return new Promise((resolve, reject) => {
    conn.query(query, values, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results.length > 0 ? results[0] : null);
      }
      conn.end();
    });
  });
}

//Metodo para crear usuarios
async function createUser(user) {
  const conn = await connect();

  // Hashea la contraseña antes de almacenarla
  const hashedPassword = await bcrypt.hash(user.password, saltRounds);

  const query = 'INSERT INTO usuarios (nombre, email, password) VALUES (?, ?, ?)';
  const values = [user.nombre, user.email, hashedPassword];

  return new Promise((resolve, reject) => {
    conn.query(query, values, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results.affectedRows > 0);
      }
      conn.end();
    });
  });
}

//Metodo para obtener un usuario por email y contraseña
async function getUserByEmailAndPassword(email, password) {
  const conn = await connect();
  const query = 'SELECT * FROM usuarios WHERE email = ? AND password = ?';
  const values = [email, password];

  return new Promise((resolve, reject) => {
    conn.query(query, values, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results.length > 0 ? results[0] : null);
      }
      conn.end();
    });
  });
}

//Metodo para verificar si un usuario existe
async function existsInEitherTable(email, password) {
  const conn = await connect();
  const query = 'SELECT * FROM usuarios WHERE email = ? AND password = ?';
  const values = [email, password];

  return new Promise((resolve, reject) => {
    conn.query(query, values, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results.length > 0);
      }
      conn.end();
    });
  });
}

//Metodo para actualizar un usuario
async function updateUser(user) {
  const conn = await connect();
  const query = 'UPDATE usuarios SET nombre = ?, email = ?, password = ? WHERE id = ?';
  const values = [user.nombre, user.email, user.password, user.id];

  return new Promise((resolve, reject) => {
    conn.query(query, values, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results.affectedRows > 0);
      }
      conn.end();
    });
  });
}

//Metodo para eliminar un usuario
async function deleteUser(id) {
  const conn = await connect();
  const query = 'DELETE FROM usuarios WHERE id = ?';
  const values = [id];

  return new Promise((resolve, reject) => {
    conn.query(query, values, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results.affectedRows > 0);
      }
      conn.end();
    });
  });
}

//Metodo para obtener todos los usuarios
async function getUsers() {
  const conn = await connect();
  const query = 'SELECT * FROM usuarios';

  return new Promise((resolve, reject) => {
    conn.query(query, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results);
      }
      conn.end();
    });
  });
}

//Metodo para obtener un usuario por id
async function getUserById(id) {
  const conn = await connect();
  const query = 'SELECT * FROM usuarios WHERE id = ?';
  const values = [id];

  return new Promise((resolve, reject) => {
    conn.query(query, values, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results.length > 0 ? results[0] : null);
      }
      conn.end();
    });
  });
}


//Metodo para actualizar saldo de un usuario
async function updateUserBalance(user) {
  const conn = await connect();
  const query = 'UPDATE usuarios SET saldo = ? WHERE id = ?';
  const values = [user.saldo, user.id];

  return new Promise((resolve, reject) => {
    conn.query(query, values, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results.affectedRows > 0);
      }
      conn.end();
    });
  });
}
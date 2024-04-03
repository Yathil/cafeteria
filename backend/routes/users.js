const mysql = require('mysql');

// Método para conectarse a la base de datos
function connect() {
  return new Promise((resolve, reject) => {
    connection.connect((err) => {
      if (err) {
        reject(err);
      } else {
        resolve(connection);
      }
    });
  });
}

// Método para desconectarse de la base de datos
function closeConnection() {
  return new Promise((resolve, reject) => {
    connection.end((err) => {
      if (err) {
        reject(err);
      } else {
        resolve();
      }
    });
  });
}


// Obtener un usuario
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

// Verificar si un usuario existe
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

// Actualizar un usuario
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



module.exports = { createUser, getUserByEmailAndPassword, updateUser, deleteUser };
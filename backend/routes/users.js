const bcrypt = require('bcrypt');
const saltRounds = 10;

// Obtener un usuario
async function getUserByEmail(pool, email) {
  const query = 'SELECT * FROM usuarios WHERE email = ?';
  const values = [email];

  return new Promise((resolve, reject) => {
    pool.query(query, values, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results.length > 0 ? results[0] : null);
      }
    });
  });
}

// Verificar si un usuario existe
async function existsInEitherTable(pool, email) {
  const query = 'SELECT * FROM usuarios WHERE email = ?';
  const values = [email];

  return new Promise((resolve, reject) => {
    pool.query(query, values, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results.length > 0);
      }
    });
  });
}

// Actualizar un usuario
async function updateUser(pool, user) {
  const hashedPassword = await bcrypt.hash(user.password, saltRounds);
  const query = 'UPDATE usuarios SET nombre = ?, email = ?, password = ? WHERE id = ?';
  const values = [user.nombre, user.email, hashedPassword, user.id];

  return new Promise((resolve, reject) => {
    pool.query(query, values, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results.affectedRows > 0);
      }
    });
  });
}

module.exports = { getUserByEmail, updateUser, existsInEitherTable };
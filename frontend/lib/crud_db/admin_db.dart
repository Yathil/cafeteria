import '../services/db_conection.dart';

class AdminDB {
  final DBConnection _dbConnection;

  AdminDB(this._dbConnection);

  Future<void> createUser(String name, String password, String email, String saldo, String edad) async {
    var query = 'INSERT INTO usuarios (name, password_hash, email, saldo, edad) VALUES (?, ?, ?, ?, ?)';
    await _dbConnection.executeNonQuery(query, [name, password, email, saldo, edad]);
  }

  Future<void> updateUser(int id, String name, String password, String email, String saldo, String edad) async {
    var query = 'UPDATE usuarios SET name = ?, password_hash = ?, email = ?, saldo = ?, edad = ? WHERE id = ?';
    await _dbConnection.executeNonQuery(query, [name, password, email, saldo, edad, id]);
  }

  Future<void> deleteUser(int id) async {
    var query = 'DELETE FROM usuarios WHERE id = ?';
    await _dbConnection.executeNonQuery(query, [id]);
  }

  // Otras funciones específicas para los administradores
}

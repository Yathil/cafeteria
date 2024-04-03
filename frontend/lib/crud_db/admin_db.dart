import '../services/db_conection.dart';

class AdminDB {
  final DBConnection _dbConnection;

  AdminDB(this._dbConnection);

  Future<void> createUser(String username, String password) async {
    var query = 'INSERT INTO users (username, password) VALUES (?, ?)';
    await _dbConnection.executeNonQuery(query, [username, password]);
  }

  // Otras funciones específicas para los administradores
}

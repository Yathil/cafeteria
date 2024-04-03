import '../services/db_conection.dart';

class UserDB {
  final DBConnection _dbConnection;

  UserDB(this._dbConnection);

  Future<List<Map<String, dynamic>>> getUsers() async {
    var query = 'SELECT * FROM users';
    return await _dbConnection.executeQuery(query);
  }

  // Otras funciones específicas para los usuarios
}

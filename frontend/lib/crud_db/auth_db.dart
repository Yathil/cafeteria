import '../models/user_model.dart';
import '../models/admin_model.dart';
import '../models/perfil_usuario_model.dart';
import '../services/db_conection.dart';

class AuthDB {
  final DBConnection _dbConnection;

  AuthDB(this._dbConnection);

  Future<UsuarioModel> authenticateAndGetUser(String username, String password) async {
    var userQuery = 'SELECT * FROM usuarios WHERE name = ? AND password_hash = ?';
    var adminQuery = 'SELECT * FROM admins WHERE username = ? AND password = ?';

    var userResults = await _dbConnection.executeQuery(userQuery, [username, password]);
    var adminResults = await _dbConnection.executeQuery(adminQuery, [username, password]);

    if (adminResults.isNotEmpty) {
      var row = adminResults.first;
      return AdminModel(
        id: row['id'],
        nombre: row['name'],
        email: row['email'],
        passwordHash: row['password_hash'],
        passwordSalt: row['password_salt'],
        // Asegúrate de asignar todos los campos necesarios aquí
      );
    } else if (userResults.isNotEmpty) {
      var row = userResults.first;
      return PerfilUsuarioModel(
        id: row['id'],
        nombre: row['name'],
        email: row['email'],
        passwordHash: row['password_hash'],
        passwordSalt: row['password_salt'],
        edad: row['edad'],
        saldo: row['saldo'],
        // Asegúrate de asignar todos los campos necesarios aquí
      );
    } else {
      throw Exception('No se encontró al usuario');
    }
  }
}

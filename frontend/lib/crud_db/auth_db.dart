import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../models/user_model.dart';
import '../models/admin_model.dart';
import '../models/perfil_usuario_model.dart';
import '../services/db_conection.dart';

class AuthDB {
  final DBConnection _dbConnection;

  AuthDB(this._dbConnection);

  Future<UsuarioModel?> authenticateAndGetUser(String useremail, String password) async {
    // Hash the password
    var passwordHash = sha256.convert(utf8.encode(password)).toString();

    var userQuery = 'SELECT * FROM usuarios WHERE email = ? AND password_hash = ?';
    var adminQuery = 'SELECT * FROM administradores WHERE email = ? AND password_hash = ?';

    var userResults = await _dbConnection.executeQuery(userQuery, [useremail, passwordHash]);
    print('User Results: $userResults');

    var adminResults = await _dbConnection.executeQuery(adminQuery, [useremail, passwordHash]);
    print('Admin Results: $adminResults');

    if (adminResults.isNotEmpty) {
      var row = adminResults.first;
      return AdminModel(
        id: row['id'],
        nombre: row['nombre'],
        email: row['email'],
        passwordHash: row['password_hash'],
        // Asegúrate de asignar todos los campos necesarios aquí
      );
    } else if (userResults.isNotEmpty) {
      var row = userResults.first;
      return PerfilUsuarioModel(
        id: row['id'],
        nombre: row['name'],
        email: row['email'],
        passwordHash: row['password_hash'],
        edad: row['edad'],
        saldo: row['saldo'],
        // Asegúrate de asignar todos los campos necesarios aquí
      );
    } else {
      return null; // Ahora es válido devolver null
    }
  }
}

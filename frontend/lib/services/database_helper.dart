import 'package:mysql1/mysql1.dart';

import '../pages/perfil_usuario/perfil_usuario_model.dart';

class DatabaseHelper {
  static Future<MySqlConnection> connect() async {
    final settings = ConnectionSettings(
      host: '127.0.0.1',
      port: 3306,
      user: 'root',
      password: '',
      db: 'flutter',
    );
    return await MySqlConnection.connect(settings);
  }

// ================== Métodos para interactuar con la tabla de usuarios ==================

// ======================
// Crear un nuevo usuario
// ======================
  static Future<bool> createUser(PerfilUsuarioModel user) async {
    final conn = await connect();
    final results = await conn.query(
      'INSERT INTO usuarios (nombre, email, password) VALUES (?, ?, ?)',
      [user.nombre, user.email, user.password],
    );
    await conn.close();

    return results.affectedRows! > 0;
  }

// ======================
// Obtener un usuario
// ======================
  static Future<dynamic> getUser(String email) async {
    final conn = await connect();
    final results = await conn.query(
      'SELECT * FROM usuarios WHERE email = ?',
      [email],
    );
    await conn.close();

    if (results.isNotEmpty) {
      return PerfilUsuarioModel.fromMap(results.first.fields);
    } else {
      return PerfilUsuarioModel.defaultValues();
    }
  }

// ======================
// Verificar si un usuario existe
// ======================
  static Future<bool> existsInEitherTable(String email, String password) async {
    final conn = await connect();
    final results = await conn.query(
      'SELECT * FROM usuarios WHERE email = ? AND password = ?',
      [email, password],
    );
    await conn.close();

    return results.isNotEmpty;
  }

// ======================
// Actualizar un usuario
// ======================
  static Future<bool> updateUser(PerfilUsuarioModel user) async {
    final conn = await connect();
    final results = await conn.query(
      'UPDATE usuarios SET nombre = ?, email = ?, password = ? WHERE id = ?',
      [user.nombre, user.email, user.password, user.id],
    );
    await conn.close();

    return results.affectedRows! > 0;
  }

// ======================
// Eliminar un usuario
// ======================
  static Future<bool> deleteUser(int id) async {
    final conn = await connect();
    final results = await conn.query(
      'DELETE FROM usuarios WHERE id = ?',
      [id],
    );
    await conn.close();

    return results.affectedRows! > 0;
  }

  // Otros métodos para interactuar con la base de datos MySQL
}

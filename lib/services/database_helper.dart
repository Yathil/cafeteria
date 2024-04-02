import 'dart:io';
import 'dart:typed_data';

import 'package:cafeteria/pages/perfil_usuario/perfil_usuario_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //=======================================================================================================
  // Método para obtener una instancia de la base de datos
  //=======================================================================================================
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'Cafeteria.db');

    // Comprueba si la base de datos existe
    final exists = await databaseExists(path);

    if (!exists) {
      // Si no existe, copia desde los assets
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copia la base de datos desde los assets a la carpeta de bases de datos
      ByteData data = await rootBundle.load(join('assets', 'db', 'Cafeteria.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Escribe los bytes copiados en el archivo de la base de datos
      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path);
  }

  //=======================================================================================================
  // Método para obtener un usuario de la base de datos
  //=======================================================================================================
  static Future<dynamic> getUser(String email) async {
    final db = await DatabaseHelper.database();

    // Realizar la consulta para obtener el usuario con el email proporcionado
    final List<Map<String, dynamic>> userMaps = await db.query(
      'usuarios',
      where: 'email = ?',
      whereArgs: [email],
    );

    // Comprobar si se encontró un usuario
    if (userMaps.isNotEmpty) {
      // Si se encontró un usuario, crear un objeto User a partir de los datos obtenidos de la base de datos
      return PerfilUsuarioModel.fromMap(userMaps.first);
    } else {
      // Si no se encontró ningún usuario, mostrar un mensaje de error o devolver un usuario predeterminado
      return PerfilUsuarioModel.defaultValues();
    }
  }

  //=======================================================================================================
  // Método para verificar si un usuario existe en la base de datos
  //=======================================================================================================
  static Future<bool> existsInEitherTable(String email, String password) async {
    final db = await DatabaseHelper.database();

    // Verifica en la tabla Usuarios
    var result = await db.rawQuery('SELECT * FROM usuarios WHERE email = ? AND password = ?', [email, password]);
    if (result.isNotEmpty) {
      return true;
    }

    // Verifica en la tabla Administradores
    result = await db.rawQuery('SELECT * FROM administradores WHERE email = ? AND password = ?', [email, password]);
    return result.isNotEmpty;
  }

  //=======================================================================================================
  // Método para obtener la edad de un usuario
  //=======================================================================================================
  static Future<bool> isUserAdult(String email) async {
    final db = await DatabaseHelper.database();

    // Buscar en la tabla Usuarios para obtener la fecha de nacimiento del usuario
    var result = await db.rawQuery('SELECT fechaNacimiento FROM usuarios WHERE email = ?', [email]);
    if (result.isNotEmpty) {
      // Suponiendo que la fecha de nacimiento está en formato de cadena (String)
      final fechaNacimientoString = result[0]['fechaNacimiento'] as String;

      // Parsear la fecha de nacimiento a DateTime
      final fechaNacimiento = DateTime.parse(fechaNacimientoString);

      // Calcular la edad del usuario
      final edad = DateTime.now().difference(fechaNacimiento).inDays ~/ 365;

      // Devolver true si el usuario es mayor de edad (18 años o más)
      return edad >= 18;
    }

    // Si el usuario no se encuentra en la tabla Usuarios, asumimos que no es mayor de edad
    return false;
  }

  //=======================================================================================================
  //Método para obtener el historial de recargas
  //=======================================================================================================
  static Future<List<Map<String, dynamic>>> getRecargas(int idUsuario) async {
    final db = await DatabaseHelper.database();
    return await db.rawQuery('SELECT * FROM historial_recargas WHERE id_usuario = ?', [idUsuario]);
  }
}

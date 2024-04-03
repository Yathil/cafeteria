import 'dart:io';

import 'package:mysql1/mysql1.dart';

class DBConnection {
  late MySqlConnection _connection;

  //constructor
  DBConnection._();

  static Future<DBConnection> connect() async {
    var dbConnection = DBConnection._();
    dbConnection._connection = await MySqlConnection.connect(ConnectionSettings(
      host: '10.0.2.2',
      port: 3306,
      user: 'root',
      db: 'flutter',
    ));
    print('Connection established');
    return dbConnection;
  }

  Future<List<Map<String, dynamic>>> executeQuery(String query, [List<dynamic>? values]) async {
    Results results;
    try {
      if (values == null) {
        results = await _connection.query(query);
      } else {
        results = await _connection.query(query, values);
      }
    } catch (e) {
      if (e is SocketException) {
        await connect();
        return executeQuery(query, values);
      } else {
        rethrow;
      }
    }
    return results.map((r) => r.fields).toList();
  }

  Future<void> executeNonQuery(String query, List<dynamic> values) async {
    try {
      await _connection.query(query, values);
    } catch (e) {
      if (e is SocketException) {
        await connect();
        return executeNonQuery(query, values);
      } else {
        rethrow;
      }
    }
  }

  Future<void> close() async {
    await _connection.close();
  }
}

import 'package:mysql1/mysql1.dart';

class DBConnection {
  late MySqlConnection _connection;

  Future<void> connect() async {
    _connection = await MySqlConnection.connect(ConnectionSettings(
      host: '127.0.0.1',
      port: 3306,
      user: 'root',
      password: '',
      db: 'flutter',
    ));
  }

  Future<List<Map<String, dynamic>>> executeQuery(String query, [List<dynamic>? values]) async {
    var results;
    if (values == null) {
      results = await _connection.query(query);
    } else {
      results = await _connection.query(query, values);
    }
    return results.map((r) => r.fields).toList();
  }

  Future<void> executeNonQuery(String query, List<dynamic> values) async {
    await _connection.query(query, values);
  }

  Future<void> close() async {
    await _connection.close();
  }
}

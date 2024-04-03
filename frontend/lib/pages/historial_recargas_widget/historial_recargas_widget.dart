import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'historial_recargas_model.dart';

class HistorialRecargasWidget extends StatefulWidget {
  const HistorialRecargasWidget({super.key});

  @override
  _HistorialRecargasWidgetState createState() => _HistorialRecargasWidgetState();
}

class _HistorialRecargasWidgetState extends State<HistorialRecargasWidget> {
  late Future<List<HistorialRecargasModel>> futureRecargas;

  @override
  void initState() {
    super.initState();
    futureRecargas = _getRecargas();
  }

  Future<List<HistorialRecargasModel>> _getRecargas() async {
    // Obtener una instancia de la base de datos
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'Cafeteria.db');
    final db = await openDatabase(path);

    // Realizar la consulta para obtener el historial de recargas del usuario actualmente conectado
    final List<Map<String, dynamic>> recargasMaps = await db.query(
      'recargas',
      where: 'idUsuario = ?',
      whereArgs: [await getUserId()],
    );

    // Crear una lista de objetos HistorialRecargasModel a partir de los datos obtenidos de la base de datos
    return List.generate(recargasMaps.length, (i) {
      return HistorialRecargasModel(
        id: recargasMaps[i]['id'],
        idUsuario: recargasMaps[i]['idUsuario'],
        cantidad: recargasMaps[i]['monto'],
        fecha: recargasMaps[i]['fecha'],
        idAdministrador: recargasMaps[i]['idAdministrador'],
      );
    });
  }

  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;
    if (userId == 0) {
      // Mostrar un mensaje al usuario para que inicie sesión
    }
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HistorialRecargasModel>>(
      future: futureRecargas,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Historial de recargas'),
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Recarga de \$${snapshot.data![index].cantidad}'),
                  subtitle: Text('Fecha: ${snapshot.data![index].fecha}'),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text('No se encontraron recargas'));
        }
      },
    );
  }
}

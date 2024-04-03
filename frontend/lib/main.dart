import 'package:flutter/material.dart';
import 'pages/login/login_widget.dart';
import 'services/db_conection.dart'; // Asegúrate de importar tu servicio de conexión a la base de datos

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Crea una nueva instancia de tu servicio de conexión a la base de datos
  var dbConnection = await DBConnection.connect();
  // Prueba la conexión a la base de datos
  var query = 'SELECT * FROM usuarios LIMIT 1';
  var results = await dbConnection.executeQuery(query, []);
  if (results.isNotEmpty) {
    print('Conexión a la base de datos exitosa. Primer usuario: ${results.first}');
  } else {
    print('Conexión a la base de datos exitosa, pero no hay usuarios.');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const LoginWidget(),
    );
  }
}

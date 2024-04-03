import 'package:cafeteria/models/perfil_usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:cafeteria/pages/menu_cafeteria/menu_cafeteria_widget.dart';
import 'package:cafeteria/pages/historial_compras/historial_compras_widget.dart';
import 'package:cafeteria/pages/historial_recargas_widget/historial_recargas_widget.dart';

import 'package:cafeteria/pages/editar_perfil/editar_perfil_widget.dart';

class PerfilUsuarioWidget extends StatefulWidget {
  final PerfilUsuarioModel user;

  PerfilUsuarioWidget({Key? key, required this.user}) : super(key: key);

  @override
  _PerfilUsuarioWidgetState createState() => _PerfilUsuarioWidgetState();
}

class _PerfilUsuarioWidgetState extends State<PerfilUsuarioWidget> {
  late Future<PerfilUsuarioModel> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = _getUserData();
  }

  Future<PerfilUsuarioModel> _getUserData() async {
    // Aquí podrías cargar datos adicionales del usuario si fuera necesario
    return Future.value(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PerfilUsuarioModel>(
      future: futureUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final user = snapshot.data;

          return ListView(
            children: <Widget>[
              Card(
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  leading: Icon(Icons.account_circle, size: 50),
                  title: Text(
                    'Nombre: ${user?.nombre}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Correo: ${user?.email}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            'Saldo: ',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${user?.saldo}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Botón para ir al menú de la cafetería
              _buildCustomButton(
                text: 'Menú de la Cafetería',
                icon: Icons.restaurant_menu,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuCafeteriaWidget()),
                  );
                },
              ),

              // Botón para ver el historial de compras
              _buildCustomButton(
                text: 'Historial de Compras',
                icon: Icons.shopping_cart,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistorialComprasWidget()),
                  );
                },
              ),

              // Botón para ver el historial de recargas
              _buildCustomButton(
                text: 'Historial de Recargas',
                icon: Icons.history,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistorialRecargasWidget()),
                  );
                },
              ),

              // Botón para recargar saldo
              _buildCustomButton(
                text: 'Recarga de Saldo',
                icon: Icons.attach_money,
                onPressed: () async {
                  // try {
                  //   final isUserAdult = await DatabaseHelper.isUserAdult(_getUserData() as String);
                  //   if (isUserAdult) {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => const RecargaSaldoWidget()),
                  //     );
                  //   } else {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text('No puedes recargar saldo porque no eres menor de edad')),
                  //     );
                  //   }
                  // } catch (e) {
                  //   print('Error al obtener los detalles del usuario: $e');
                  // }
                },
              ),

              // Botón para editar perfil
              _buildCustomButton(
                text: 'Editar Perfil',
                icon: Icons.edit,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditarPerfilWidget()),
                  );
                },
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // Método para construir botones personalizados
  Widget _buildCustomButton({required String text, required IconData icon, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15), // Ajusta el padding vertical
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Bordes redondeados
        ),
      ),
    );
  }
}

//widgets
import 'package:cafeteria/pages/recarga_saldo_model/recarga_saldo_widget.dart';
import 'package:flutter/material.dart';
//models
import '../../models/admin_model.dart';

//pages
import '../productos/producto_widget.dart';
import 'crear_usuario_widget.dart';

class AdminWidget extends StatefulWidget {
  final AdminModel admin;

  const AdminWidget({super.key, required this.admin});

  @override
  _AdminWidgetState createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  late Future<AdminModel> futureAdmin;

  @override
  void initState() {
    super.initState();
    futureAdmin = _getAdminData();
  }

  Future<AdminModel> _getAdminData() async {
    // Aquí podrías cargar datos adicionales del usuario si fuera necesario
    return widget.admin;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AdminModel>(
      future: futureAdmin,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final user = snapshot.data;

          return Scaffold(
            appBar: AppBar(title: const Text('Panel de Administrador')),
            body: ListView(
              children: [
                Card(
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    leading: const Icon(Icons.account_circle, size: 50),
                    title: Text(
                      'Nombre: ${user?.nombre}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Correo: ${user?.email}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        // Botones para crear usuario, añadir producto, recargar saldo
                        _buildCustomButton(
                          text: 'Usuarios',
                          icon: Icons.person_add,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CrearUsuarioWidget()),
                            );
                          },
                        ),
                        _buildCustomButton(
                          text: 'Productos',
                          icon: Icons.add_box,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ProductoWidget()),
                            );
                          },
                        ),
                        _buildCustomButton(
                          text: 'Recargar Saldo',
                          icon: Icons.attach_money,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RecargaSaldoWidget()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
        }
      },
    );
  }

  Widget _buildCustomButton({required String text, required IconData icon, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15), // Ajusta el padding vertical
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Bordes redondeados
        ),
      ),
    );
  }
}

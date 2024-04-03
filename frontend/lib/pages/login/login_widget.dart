//database
import 'package:cafeteria/models/perfil_usuario_model.dart';
import 'package:cafeteria/pages/admin/admin_widget.dart';
import 'package:cafeteria/pages/admin/crear_usuario_widget.dart';

import '../../crud_db/auth_db.dart';
import '../../services/db_conection.dart';
//models
import '../../models/admin_model.dart';
//pages
import '../perfil_usuario/perfil_usuario_widget.dart';
//widgets
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            cajapurpura(size),
            iconopersona(),
            loginform(context),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView loginform(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 250),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text('Login', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          hintText: 'ejemplo@ieseduardoprimo.es',
                          labelText: 'Correo electronico',
                          icon: Icon(Icons.alternate_email_rounded),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu correo electrónico';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _passwordController,
                        autocorrect: false,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: '******',
                          labelText: 'Contraseña',
                          icon: Icon(Icons.lock_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu contraseña';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var username = _emailController.text;
                            var password = _passwordController.text;
                            var dbConnection = await DBConnection.connect();
                            var db = AuthDB(dbConnection); // Asegúrate de conectar antes de autenticar
                            try {
                              var user = await db.authenticateAndGetUser(username, password);
                              if (user is AdminModel) {
                                // Navega a la página de administrador
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AdminWidget(admin: user)),
                                );
                              } else if (user is PerfilUsuarioModel) {
                                // Navega a la página de usuario
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PerfilUsuarioWidget(user: user)),
                                );
                              }
                            } catch (e) {
                              // Muestra un mensaje de error
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('email de usuario o contraseña incorrectos')),
                              );
                            }
                          }
                        },
                        child: const Text('Iniciar sesión'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          GestureDetector(
            onTap: () {
              // Aquí puedes manejar el evento de toque, por ejemplo, navegando a la pantalla de creación de cuenta
              Navigator.push(context, MaterialPageRoute(builder: (context) => CrearUsuarioWidget()));
            },
            child: const Text(
              'Crear una nueva cuenta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }

  SafeArea iconopersona() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

  Container cajapurpura(Size size) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1),
            Color.fromRGBO(90, 70, 178, 1),
          ],
        ),
      ),
      width: double.infinity,
      height: size.height * 0.4,
      child: Stack(
        children: [
          Positioned(top: 90, left: 30, child: burbuja()),
          Positioned(top: -40, left: -30, child: burbuja()),
          Positioned(top: -50, right: -20, child: burbuja()),
          Positioned(bottom: -50, left: 10, child: burbuja()),
          Positioned(bottom: 120, right: 20, child: burbuja()),
        ],
      ),
    );
  }

  Container burbuja() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0),
      ),
    );
  }
}

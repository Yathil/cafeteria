import 'package:cafeteria/pages/perfil_usuario/perfil_usuario_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/database_helper.dart';
import '../admin/admin_widget.dart';
import '../perfil_usuario/perfil_usuario_widget.dart';
import 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final _model = LoginModel(useremail: '', password: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // ========================
                  // EMAIL
                  // ========================
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    onSaved: (value) {
                      _model.useremail = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu usuario';
                      }
                      return null;
                    },
                  ),

                  // ========================
                  // PASSWORD
                  // ========================
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _model.password = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu contraseña';
                      }
                      return null;
                    },
                  ),

                  // ========================
                  // INICIAR SESIÓN
                  // ========================
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        bool exists = await DatabaseHelper.existsInEitherTable(_model.useremail, _model.password);
                        if (exists) {
                          // Obtén el usuario de la base de datos
                          PerfilUsuarioModel user = await DatabaseHelper.getUser(_model.useremail);
                          // Navega al perfil del usuario
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PerfilUsuarioWidget(user: user)),
                          );
                        } else {
                          // Muestra un mensaje de error
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Usuario o contraseña incorrectos'),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Iniciar sesión'),
                  )

                  // ElevatedButton(
                  //   onPressed: () async {
                  //     if (_formKey.currentState!.validate()) {
                  //       _formKey.currentState?.save();
                  //       try {
                  //         UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  //           email: _model.useremail,
                  //           password: _model.password,
                  //         );
                  //         // Navega al perfil del usuario
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(builder: (context) => const PerfilUsuarioWidget()),
                  //         );
                  //       } on FirebaseAuthException catch (e) {
                  //         if (e.code == 'user-not-found') {
                  //           ScaffoldMessenger.of(context).showSnackBar(
                  //             const SnackBar(
                  //               content: Text('No se encontró ningún usuario con ese correo electrónico.'),
                  //             ),
                  //           );
                  //         } else if (e.code == 'wrong-password') {
                  //           ScaffoldMessenger.of(context).showSnackBar(
                  //             const SnackBar(
                  //               content: Text('La contraseña es incorrecta.'),
                  //             ),
                  //           );
                  //         }
                  //       }
                  //     }
                  //   },
                  //   child: const Text('Iniciar sesión'),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'user_model.dart';

class PerfilUsuarioModel extends UsuarioModel {
  final double saldo;
  final int edad;

  PerfilUsuarioModel({
    required int id,
    required String nombre,
    required String passwordHash,
    required String passwordSalt,
    required this.saldo,
    required String email,
    required this.edad,
  }) : super(
          id: id,
          nombre: nombre,
          email: email,
          passwordHash: passwordHash,
          passwordSalt: passwordSalt,
        );

  // Método para convertir un Map a PerfilUsuarioModel
  factory PerfilUsuarioModel.fromMap(Map<String, dynamic> map) {
    return PerfilUsuarioModel(
      id: map['id'] ?? 0,
      nombre: map['name'] ?? '',
      passwordHash: map['password'] ?? '',
      passwordSalt: map['password_salt'] ?? '',
      saldo: map['saldo'] ?? 0,
      email: map['email'] ?? '',
      edad: map['edad'] ?? 0,
    );
  }

  // Método para convertir PerfilUsuarioModel a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'password': passwordHash,
      'password_salt': passwordSalt,
      'saldo': saldo,
      'email': email,
      'edad': edad,
    };
  }

  // Constructor con valores predeterminados
  PerfilUsuarioModel.defaultValues()
      : saldo = 0,
        edad = 0,
        super(
          id: 0,
          nombre: '',
          email: '',
          passwordHash: '',
          passwordSalt: '',
        );
}

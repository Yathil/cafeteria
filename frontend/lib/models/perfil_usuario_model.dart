import 'user_model.dart';

class PerfilUsuarioModel extends UsuarioModel {
  final double saldo;
  final int edad;

  PerfilUsuarioModel({
    required super.id,
    required super.nombre,
    required super.passwordHash,
    required this.saldo,
    required super.email,
    required this.edad,
  });

  // Método para convertir un Map a PerfilUsuarioModel
  factory PerfilUsuarioModel.fromMap(Map<String, dynamic> map) {
    return PerfilUsuarioModel(
      id: map['id'] ?? 0,
      nombre: map['name'] ?? '',
      passwordHash: map['password'] ?? '',
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
        );
}

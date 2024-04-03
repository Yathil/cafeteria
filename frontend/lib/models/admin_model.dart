import 'user_model.dart';

class AdminModel extends UsuarioModel {
  AdminModel({
    required int id,
    required String nombre,
    required String email,
    required String passwordHash,
    required String passwordSalt,
  }) : super(
          id: id,
          nombre: nombre,
          email: email,
          passwordHash: passwordHash,
          passwordSalt: passwordSalt,
        );

// Método para convertir un json a AdminModel
  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      passwordHash: json['passwordHash'],
      passwordSalt: json['passwordSalt'],
    );
  }

// Método para convertir AdminModel a json

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'passwordHash': passwordHash,
      'passwordSalt': passwordSalt,
    };
  }

// Constructor con valores predeterminados
  AdminModel.defaultValues()
      : super(
          id: 0,
          nombre: '',
          email: '',
          passwordHash: '',
          passwordSalt: '',
        );
}

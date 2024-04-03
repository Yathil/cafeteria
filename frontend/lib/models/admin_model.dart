import 'user_model.dart';

class AdminModel extends UsuarioModel {
  AdminModel({
    required super.id,
    required super.nombre,
    required super.email,
    required super.passwordHash,
  });

// Método para convertir un json a AdminModel
  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      passwordHash: json['passwordHash'],
    );
  }

// Método para convertir AdminModel a json

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'passwordHash': passwordHash,
    };
  }

// Constructor con valores predeterminados
  AdminModel.defaultValues()
      : super(
          id: 0,
          nombre: '',
          email: '',
          passwordHash: '',
        );
}

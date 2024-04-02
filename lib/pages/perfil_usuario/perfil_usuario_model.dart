class PerfilUsuarioModel {
  final int id;
  final String name;
  final String password;
  final double saldo;
  final String email;
  //edad
  final int edad;

  PerfilUsuarioModel({
    required this.id,
    required this.name,
    required this.password,
    required this.saldo,
    required this.email,
    required this.edad,
  });

  // Método para convertir un Map a PerfilUsuarioModel
  factory PerfilUsuarioModel.fromMap(Map<String, dynamic> map) {
    return PerfilUsuarioModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      saldo: map['saldo'] ?? 0.0,
      email: map['email'] ?? '',
      edad: map['edad'] ?? 0,
    );
  }

  //Metodo para saber si es mayor de edad

  // Método para convertir PerfilUsuarioModel a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'saldo': saldo,
      'email': email,
      'edad': edad,
    };
  }

  PerfilUsuarioModel.defaultValues()
      : id = 0,
        name = '',
        password = '',
        saldo = 0,
        email = '',
        edad = 0;
}
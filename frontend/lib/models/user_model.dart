abstract class UsuarioModel {
  final int id;
  final String nombre;
  final String email;
  final String passwordHash;

  UsuarioModel({
    required this.id,
    required this.nombre,
    required this.email,
    required this.passwordHash,
  });

  //defaultvalues
  UsuarioModel.defaultValues()
      : id = 0,
        nombre = '',
        email = '',
        passwordHash = '';
}

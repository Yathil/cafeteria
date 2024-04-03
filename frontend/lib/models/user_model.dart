abstract class UsuarioModel {
  final int id;
  final String nombre;
  final String email;
  final String passwordHash;
  final String passwordSalt;

  UsuarioModel({
    required this.id,
    required this.nombre,
    required this.email,
    required this.passwordHash,
    required this.passwordSalt,
  });

  //defaultvalues
  UsuarioModel.defaultValues()
      : id = 0,
        nombre = '',
        email = '',
        passwordHash = '',
        passwordSalt = '';
}

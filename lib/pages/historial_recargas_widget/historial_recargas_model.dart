class HistorialRecargasModel {
  final int id;
  final int idUsuario;
  final DateTime fecha;
  final double cantidad;
  final int idAdministrador;

  HistorialRecargasModel({
    required this.id,
    required this.idUsuario,
    required this.fecha,
    required this.cantidad,
    required this.idAdministrador,
  });

  factory HistorialRecargasModel.fromMap(Map<String, dynamic> map) {
    return HistorialRecargasModel(
      id: map['id'],
      idUsuario: map['id_usuario'],
      fecha: DateTime.parse(map['fecha']),
      cantidad: map['cantidad'],
      idAdministrador: map['id_administrador'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_usuario': idUsuario,
      'fecha': fecha.toIso8601String(),
      'cantidad': cantidad,
      'id_administrador': idAdministrador,
    };
  }

  HistorialRecargasModel.defaultValues()
      : id = 0,
        idUsuario = 0,
        fecha = DateTime.now(),
        cantidad = 0,
        idAdministrador = 0;
}

class RecargaSaldoModel {
  final String _numeroTarjeta;
  final String _monto;
  final String _fecha;
  final String _hora;

  RecargaSaldoModel(this._numeroTarjeta, this._monto, this._fecha, this._hora);

  String get numeroTarjeta => _numeroTarjeta;
  String get monto => _monto;
  String get fecha => _fecha;
  String get hora => _hora;
}

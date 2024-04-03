class RecargaSaldoModel {
  String _numeroTarjeta;
  String _monto;
  String _fecha;
  String _hora;

  RecargaSaldoModel(this._numeroTarjeta, this._monto, this._fecha, this._hora);

  String get numeroTarjeta => _numeroTarjeta;
  String get monto => _monto;
  String get fecha => _fecha;
  String get hora => _hora;
}

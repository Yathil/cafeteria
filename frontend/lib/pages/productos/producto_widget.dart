import 'package:flutter/material.dart';

class ProductoWidget extends StatefulWidget {
  @override
  _ProductoWidget createState() => _ProductoWidget();
}

class _ProductoWidget extends State<ProductoWidget> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nombreController = TextEditingController();
  final _precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrar Producto'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'ID del Producto',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el ID del producto';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre del Producto',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el nombre del producto';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _precioController,
              decoration: const InputDecoration(
                labelText: 'Precio del Producto',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el precio del producto';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Aquí podrías añadir el producto a la base de datos
                }
              },
              child: const Text('Añadir Producto'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Aquí podrías eliminar el producto de la base de datos usando el ID
                }
              },
              child: const Text('Eliminar Producto'),
            ),
          ],
        ),
      ),
    );
  }
}

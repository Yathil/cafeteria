import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/admin/panel');
          },
          child: Text('Admin Panel'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ConfiguracoesScreen extends StatelessWidget {
  static const routeName = '/settings-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey[200],
        ),
      ),
    );
  }
}

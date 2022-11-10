import 'package:flutter/material.dart';

class ConfiguracoesScreen extends StatelessWidget {
  static const routeName = '/settings-screen';

  const ConfiguracoesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey[200],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../globals.dart' as globals;

class InfoHospedeScreen extends StatelessWidget {
  const InfoHospedeScreen({Key? key}) : super(key: key);
  static const routeName = '/info-hosp-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        child: Text(globals.loginData.toString()),
      ),
    );
  }
}

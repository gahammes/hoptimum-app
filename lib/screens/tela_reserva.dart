import 'package:flutter/material.dart';

import '../models/quarto.dart';
import '../widgets/reserva_item.dart';
import '../globals.dart' as globals;

class TelaReserva extends StatelessWidget {
  const TelaReserva({Key? key}) : super(key: key);
  static const routeName = '/reserva-screen';

  @override
  Widget build(BuildContext context) {
    //print(globals.quartosList);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Text('RESERVAS'),
        ),
        body: SizedBox(
          height: 700,
          child: ListView.builder(
            itemCount: globals.quartosList.length,
            itemBuilder: (context, index) {
              return ReservaItem(quarto: globals.quartosList[index]);
            },
          ),
        ));
  }
}

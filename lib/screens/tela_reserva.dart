import 'package:dashboard_tcc/models/quarto.dart';
import 'package:dashboard_tcc/widgets/reserva_item.dart';
import 'package:flutter/material.dart';

class TelaReserva extends StatelessWidget {
  const TelaReserva({Key? key}) : super(key: key);
  static const routeName = '/reserva-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text('RESERVAS'),
        ),
        body: SizedBox(
          height: 700,
          child: ListView.builder(
            itemCount: QUARTOS.length,
            itemBuilder: (context, index) {
              return ReservaItem(quarto: QUARTOS[index]);
            },
          ),
        ));
  }
}

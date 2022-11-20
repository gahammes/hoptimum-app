import 'package:flutter/material.dart';
import 'package:hoptimum/models/providers/auth.dart';
import 'package:hoptimum/screens/tela_reserva.dart';
import 'package:provider/provider.dart';

class SemReservaScreen extends StatelessWidget {
  const SemReservaScreen({Key? key}) : super(key: key);
  static const routeName = '/sem-reserva-scren';

  void logout(BuildContext context) {
    Provider.of<Auth>(context, listen: false).logout();
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 248, 141, 117),
                  Color.fromARGB(255, 248, 128, 101),
                  Color.fromARGB(255, 246, 106, 75),
                  Color(0xffF75E3B),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(TelaReserva.routeName);
                  },
                  child: Text('Fazer reserva'),
                ),
                ElevatedButton(
                  onPressed: () => logout(context),
                  child: const Text('Sair'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

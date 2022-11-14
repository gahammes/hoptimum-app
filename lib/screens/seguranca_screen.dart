import 'package:flutter/material.dart';

import '../widgets/seguranca_list.dart';
import '../models/seguranca.dart';

class SegurancaScreen extends StatefulWidget {
  const SegurancaScreen({Key? key}) : super(key: key);

  @override
  State<SegurancaScreen> createState() => _SegurancaScreen();
}

class _SegurancaScreen extends State<SegurancaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe1e1e1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 640, //TODO: aqui da overflow
              //margin: EdgeInsets.only(top: 0),
              child: SegurancaList(segurancaLog),
            ),
          ],
        ),
      ),
    );
  }
}

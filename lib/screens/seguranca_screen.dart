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
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      185.0) *
                  1.08,
              child: SegurancaList(segurancaLog),
            ),
          ],
        ),
      ),
    );
  }
}

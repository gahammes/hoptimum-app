import 'package:dashboard_tcc/models/data/seguranca_data.dart';
import 'package:dashboard_tcc/widgets/seguranca_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import '../models/seguranca.dart';
import '../widgets/new_log.dart';
import 'package:dashboard_tcc/globals.dart' as globals;

class SegurancaScreen extends StatefulWidget {
  @override
  State<SegurancaScreen> createState() => _SegurancaScreen();
}

class _SegurancaScreen extends State<SegurancaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe1e1e1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 640, //TODO: aqui da overflow
              //margin: EdgeInsets.only(top: 0),
              child:
                  SEGURANCA_DATA.isEmpty ? null : SegurancaList(SEGURANCA_DATA),
            ),
          ],
        ),
      ),
    );
  }
}

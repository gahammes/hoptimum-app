import 'package:dashboard_tcc/models/data/notificacao_data.dart';
import 'package:dashboard_tcc/widgets/notificacao_list.dart';
import 'package:flutter/material.dart';

class NotificacaoScreen extends StatelessWidget {
  const NotificacaoScreen({Key? key}) : super(key: key);

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
              height: 630, //TODO: aqui da overflow
              margin: EdgeInsets.only(top: 10),
              child: NotificacaoList(NOTIFICACAO_DATA),
            ),
          ],
        ),
      ),
    );
  }
}

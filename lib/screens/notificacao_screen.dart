import 'package:flutter/material.dart';
import 'package:hoptimum/widgets/notificacao_list.dart';

import '../models/notificacao.dart';
import '../widgets/notificacao_list.dart';

class NotificacaoScreen extends StatefulWidget {
  const NotificacaoScreen({Key? key}) : super(key: key);

  @override
  State<NotificacaoScreen> createState() => _NotificacaoScreenState();
}

class _NotificacaoScreenState extends State<NotificacaoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe1e1e1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 640, //TODO: aqui da overflow
              //margin: const EdgeInsets.only(top: 10),
              child: NotificacaoList(notificacoes),
            ),
          ],
        ),
      ),
    );
  }
}

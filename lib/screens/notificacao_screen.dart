import 'package:flutter/material.dart';

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
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      185.0) *
                  1.08,
              child: NotificacaoList(notificacoes),
            ),
          ],
        ),
      ),
    );
  }
}

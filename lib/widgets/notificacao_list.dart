import 'package:flutter/material.dart';

import '../models/notificacao.dart';

class NotificacaoList extends StatelessWidget {
  final List<Notificacao> notificacaoLogs;

  const NotificacaoList(this.notificacaoLogs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return notificacaoLogs.isEmpty
        ? Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                // Text(
                //   'Sem despesas ainda....',
                //   style: Theme.of(context).textTheme.headline6,
                // ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Toque em + para fazer solicitações e pedidos.',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/tw.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return notificacaoLogs[index].tag != 'serv'
                  ? Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: const Color(0xfff5f5f5),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: ListTile(
                        leading: SizedBox(
                          //width: 85,
                          height: 55,
                          child: Card(
                            color: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FittedBox(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 8,
                                ),
                                child: const Icon(
                                  Icons.restaurant,
                                  color: Colors.black,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          notificacaoLogs[index].title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notificacaoLogs[index].cod,
                            ),
                            Text(
                              notificacaoLogs[index].date,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Theme.of(context).colorScheme.secondary,
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: ListTile(
                        leading: SizedBox(
                          //width: 85,
                          height: 55,
                          child: Card(
                            color: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FittedBox(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 8,
                                ),
                                child: const Icon(
                                  Icons.king_bed,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          notificacaoLogs[index].title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notificacaoLogs[index].cod,
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              notificacaoLogs[index].date,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
            },
            itemCount: notificacaoLogs.length,
          );
  }
}

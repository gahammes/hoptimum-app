import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../models/despesa.dart';

class DespesaList extends StatelessWidget {
  final List<Despesa> despesas;

  const DespesaList(this.despesas, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //transactions = transactions.toList();
    return ListView.builder(
      itemCount: despesas.length,
      itemBuilder: (ctx, index) {
        // for (var i = 0; i < transactions.length; i++) {
        //   if (transactions[i].title == 'Diária') {
        //     Transaction move = transactions[i];
        //     transactions.removeAt(i);
        //     transactions.insert(0, move);
        //   }
        // }
        return despesas[index].title != 'Diária'
            ? Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: const Color(0xfff5f5f5),
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                child: ListTile(
                  leading: SizedBox(
                    width: 85,
                    height: 50,
                    child: Card(
                      //color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Color.fromARGB(255, 255, 135, 108),
                              Color.fromARGB(255, 248, 128, 101),
                              Color.fromARGB(255, 246, 106, 75),
                              Color(0xffF75E3B),
                            ],
                            stops: [0.1, 0.4, 0.7, 0.9],
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: FittedBox(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 8,
                            ),
                            child: Text(
                              'R\$${despesas[index].amount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Container(
                    child: AutoSizeText(
                      despesas[index].title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.MMMMEEEEd('pt_BR')
                            .format(despesas[index].date),
                      ),
                      Text(
                        DateFormat.Hm('pt_BR').format(despesas[index].date),
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
                  vertical: 8,
                  horizontal: 20,
                ),
                child: ListTile(
                  leading: SizedBox(
                    width: 85,
                    height: 50,
                    child: Card(
                      color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Color.fromARGB(255, 255, 135, 108),
                              Color.fromARGB(255, 248, 128, 101),
                              Color.fromARGB(255, 246, 106, 75),
                              Color(0xffF75E3B),
                            ],
                            stops: [0.1, 0.4, 0.7, 0.9],
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: FittedBox(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 8,
                            ),
                            child: Text(
                              'R\$${despesas[index].amount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    despesas[index].title,
                    style: const TextStyle(
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.MMMMEEEEd('pt_BR')
                            .format(despesas[index].date),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        DateFormat.Hm('pt_BR').format(despesas[index].date),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}

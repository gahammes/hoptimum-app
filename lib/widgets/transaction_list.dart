import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    transactions = transactions.toList();
    return transactions.isEmpty
        ? Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                // Text(
                //   'Sem despesas ainda....',
                //   style: Theme.of(context).textTheme.headline6,
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Toque em + para fazer solicitações e pedidos.',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
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
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              // for (var i = 0; i < transactions.length; i++) {
              //   if (transactions[i].title == 'Diária') {
              //     Transaction move = transactions[i];
              //     transactions.removeAt(i);
              //     transactions.insert(0, move);
              //   }
              // }
              return transactions[index].title != 'Diária'
                  ? Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Color(0xfff5f5f5),
                      elevation: 5,
                      margin: EdgeInsets.symmetric(
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
                                gradient: LinearGradient(
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
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    'R\$${transactions[index].amount.toStringAsFixed(2)}',
                                    style: TextStyle(
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
                          transactions[index].title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.MMMMEEEEd('pt_BR')
                                  .format(transactions[index].date),
                            ),
                            Text(
                              DateFormat.Hm('pt_BR')
                                  .format(transactions[index].date),
                            ),
                          ],
                        ),
                        // trailing: IconButton(
                        //   icon: Icon(Icons.info),
                        //   padding: EdgeInsets.all(5),
                        //   constraints: BoxConstraints(),
                        //   color: Theme.of(context).disabledColor,
                        //   hoverColor: Theme.of(context).errorColor,
                        //   onPressed: () => deleteTx(transactions[index].id),
                        // ),
                      ),
                    )
                  : Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Theme.of(context).colorScheme.secondary,
                      elevation: 5,
                      margin: EdgeInsets.symmetric(
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
                                gradient: LinearGradient(
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
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    'R\$${transactions[index].amount.toStringAsFixed(2)}',
                                    style: TextStyle(
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
                          transactions[index].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.MMMMEEEEd('pt_BR')
                                  .format(transactions[index].date),
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              DateFormat.Hm('pt_BR')
                                  .format(transactions[index].date),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          );
  }
}

import 'package:dashboard_tcc/models/data/despesas_data.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/chart.dart';
import '../widgets/new_transactions.dart';
import '../widgets/transaction_list.dart';

class DespesasScreen extends StatefulWidget {
  @override
  State<DespesasScreen> createState() => _DespesasScreen();
}

class _DespesasScreen extends State<DespesasScreen> {
  final List<Transaction> _userTransactions = DESPESAS_DATA;
  DateTime latestDate = DateTime(2022);

  // void _addNewTransaction(String title, double amount, DateTime chosenDate) {
  //   final newTx = Transaction(
  //     id: DateTime.now().toString(),
  //     title: title,
  //     amount: amount,
  //     date: chosenDate,
  //   );

  //   setState(() {
  //     _userTransactions.add(newTx);
  //   });
  // }

  DateTime getLatestDate() {
    for (var elem in DESPESAS_DATA) {
      if (elem.date.isAfter(latestDate)) {
        latestDate = elem.date;
      }
    }
    return latestDate;
  }

  List<Transaction> get _recentTransactions {
    return DESPESAS_DATA.where((element) {
      return element.date.isAfter(
        getLatestDate().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  // void _startAddNewTransaction(BuildContext ctx) {
  //   showModalBottomSheet(
  //       context: ctx,
  //       builder: (_) {
  //         return NewTransaction(_addNewTransaction);
  //       });
  // }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final routeArgs =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, List<Widget>>;
    //final title = routeArgs['title'];
    // final actions = routeArgs['actions'];

    return Scaffold(
      backgroundColor: Color(0xffe1e1e1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) *
                    0.23,
                child: Chart(_recentTransactions)),
            Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) *
                    0.59,
                child: TransactionList(_userTransactions, _deleteTransaction)),
          ],
        ),
      ),
    );
  }
}

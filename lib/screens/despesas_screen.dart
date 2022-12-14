import 'package:flutter/material.dart';

import '../models/despesa.dart';
import '../widgets/grafico.dart';
import '../widgets/despesa_list.dart';

class DespesasScreen extends StatefulWidget {
  const DespesasScreen({Key? key}) : super(key: key);

  @override
  State<DespesasScreen> createState() => _DespesasScreen();
}

class _DespesasScreen extends State<DespesasScreen> {
  DateTime latestDate = DateTime(DateTime.now().year);

  DateTime getLatestDate() {
    for (var elem in despesasLog) {
      if (elem.date.isAfter(latestDate)) {
        latestDate = elem.date;
      }
    }
    return latestDate;
  }

  List<Despesa> get _recentTransactions {
    return despesasLog.where((element) {
      return element.date.isAfter(
        getLatestDate().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

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
              child: Grafico(_recentTransactions),
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) *
                  0.25,
            ),
            SizedBox(
              child: DespesaList(despesasLog),
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      185.0) *
                  0.75,
            ),
          ],
        ),
      ),
    );
  }
}

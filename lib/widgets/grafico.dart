import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../models/despesa.dart';
import '../widgets/chart_bar.dart';

class Grafico extends StatelessWidget {
  final List<Despesa> despesasRecentes;

  const Grafico(this.despesasRecentes, {Key? key}) : super(key: key);

  DateTime getLatestDate() {
    var latestDate = DateTime(2022);
    for (var elem in despesasLog) {
      if (elem.date.isAfter(latestDate)) {
        latestDate = elem.date;
      }
    }
    return latestDate;
  }

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = getLatestDate().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var tx in despesasRecentes) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }

      return {
        'day':
            DateFormat.E('pt_BR').format(weekDay).substring(0, 1).toUpperCase(),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: const Color(0xfff5f5f5),
      elevation: 6,
      margin: const EdgeInsets.only(right: 20, left: 20, bottom: 4, top: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'].toString(),
                  (data['amount'] as double),
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}

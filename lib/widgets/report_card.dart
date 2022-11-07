import 'package:dashboard_tcc/models/report.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class ReportCard extends StatefulWidget {
  final Report report;

  ReportCard(this.report);

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Theme.of(context).colorScheme.secondary,
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Column(
        children: [
          ListTile(
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
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      child: widget.report.tag == 'cartao'
                          ? Icon(
                              Icons.key,
                              color: Colors.black,
                              size: 50,
                            )
                          : Icon(
                              Icons.directions_car,
                              color: Colors.black,
                              size: 50,
                            )),
                ),
              ),
            ),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.report.nome,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quarto ${widget.report.numQuart.toString()}.',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  DateFormat.Hm('pt_BR').format(widget.report.hora),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            trailing: widget.report.tag == 'carro'
                ? Icon(null)
                : Icon(
                    Icons.block,
                    color: Colors.red,
                  ),
          ),
          ExpansionTile(
            collapsedBackgroundColor: Color(0xfff5f5f5),
            backgroundColor: Color(0xfff5f5f5),
            title: Text(
              'Detalhes',
              style: TextStyle(fontSize: 16),
            ),
            childrenPadding:
                EdgeInsets.only(left: 16.0, bottom: 15.0, right: 16.0),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            children: [
              Text(
                widget.report.detalhes,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

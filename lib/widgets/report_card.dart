import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/report.dart';

class ReportCard extends StatefulWidget {
  final Report report;

  const ReportCard(this.report, {Key? key}) : super(key: key);

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
      margin: const EdgeInsets.symmetric(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
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
                    // margin: const EdgeInsets.symmetric(
                    //   vertical: 10,
                    //   horizontal: 8,
                    // ),
                    child: const Icon(
                      Icons.warning_rounded,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.report.nome,
                style: const TextStyle(
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
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  DateFormat.Hm('pt_BR').format(widget.report.hora),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ExpansionTile(
            collapsedBackgroundColor: const Color(0xfff5f5f5),
            backgroundColor: const Color(0xfff5f5f5),
            title: const Text(
              'Detalhes',
              style: TextStyle(fontSize: 16),
            ),
            childrenPadding:
                const EdgeInsets.only(left: 16.0, bottom: 15.0, right: 16.0),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            children: [
              Text(
                widget.report.detalhes,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

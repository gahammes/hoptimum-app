import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../models/seguranca.dart';
import '../globals.dart' as globals;

class SegurancaList extends StatefulWidget {
  final List<Seguranca> informationLogs;

  const SegurancaList(this.informationLogs, {Key? key}) : super(key: key);

  @override
  State<SegurancaList> createState() => _SegurancaListState();
}

class _SegurancaListState extends State<SegurancaList> {
  late TextEditingController inputController;
  final listKey = GlobalKey<AnimatedListState>();
  var userInput = '';

  @override
  void initState() {
    super.initState();
    inputController = TextEditingController();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  SizeTransition buildCardAni(BuildContext context, String title, String info,
      String date, String tag, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: tag == 'car'
            ? const Color(0xfff5f5f5)
            : Theme.of(context).colorScheme.secondary,
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: ListTile(
          leading: SizedBox(
            height: 55,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
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
                child: FittedBox(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                    child: tag == 'car'
                        ? const Icon(
                            Icons.directions_car,
                            color: Colors.black,
                            size: 50,
                          )
                        : const Icon(
                            Icons.key,
                            color: Colors.white,
                            size: 50,
                          ),
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: tag == 'car' ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                info,
                style: TextStyle(
                    color: tag == 'car' ? Colors.black : Colors.white),
              ),
              AutoSizeText(
                DateFormat.MMMMEEEEd('pt_BR').add_Hms().format(
                    DateTime.parse(date).subtract(const Duration(hours: 3))),
                style: TextStyle(
                    color: tag == 'car' ? Colors.black : Colors.white),
                maxLines: 1,
              ),
            ],
          ),
          trailing: null,
        ),
      ),
    );
  }

  AnimatedList animatedList() {
    var listItems = widget.informationLogs;
    return AnimatedList(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      key: globals.listKey,
      initialItemCount: widget.informationLogs.length,
      itemBuilder: (context, index, animation) {
        return buildCardAni(
          context,
          listItems[index].title,
          listItems[index].info,
          listItems[index].date,
          listItems[index].tag,
          animation,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 1), () {
          setState(() {});
        });
      },
      child: animatedList(),
    );
  }
}

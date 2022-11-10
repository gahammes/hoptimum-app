import 'package:dashboard_tcc/models/data/seguranca_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../models/seguranca.dart';
import '../globals.dart' as globals;

class SegurancaList extends StatefulWidget {
  List<Seguranca> informationLogs;

  SegurancaList(this.informationLogs);

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

  // Future<String?> openDialog() => showDialog<String>(
  //       context: context,
  //       builder: (contex) => AlertDialog(
  //         title: const Text(
  //           'Descreva o problema',
  //           style: TextStyle(
  //               color: Colors.black, fontSize: 16, fontFamily: 'Quicksand'),
  //         ),
  //         content: TextField(
  //           maxLines: null,
  //           autofocus: true,
  //           onSubmitted: (_) => submitInput(),
  //           controller: inputController,
  //           maxLength: 100,
  //           decoration: InputDecoration(
  //             border: InputBorder.none,
  //             hintText: 'Digite aqui...',
  //             hintStyle: TextStyle(
  //               color: Colors.black,
  //               fontFamily: 'Quicksand',
  //               fontSize: 12,
  //             ),
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 inputController.clear();
  //               },
  //               child: Text('Cancelar')),
  //           TextButton(onPressed: submitInput, child: Text('Enviar')),
  //         ],
  //       ),
  //     );

  // void submitInput() {
  //   Navigator.of(context).pop(inputController);
  //   inputController.clear();
  // }

  Card buildCard(BuildContext context, String title, String info, String date,
      String tag) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: tag == 'car'
          ? Color(0xfff5f5f5)
          : Theme.of(context).colorScheme.secondary, //aqui muda
      elevation: 5,
      margin: EdgeInsets.symmetric(
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
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: tag == 'car'
                    ? Icon(
                        Icons.directions_car, //aqui muda
                        color: Colors.black, //aqui muda
                        size: 50,
                      )
                    : Icon(
                        Icons.key,
                        color: Colors.white,
                        size: 50,
                      ),
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: tag == 'car' ? Colors.black : Colors.white, //aqui muda
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
                  color:
                      tag == 'car' ? Colors.black : Colors.white), //aqui muda
            ),
            Text(
              // widget.informationLogs[index].date,
              DateFormat.MMMMEEEEd('pt_BR')
                  .add_Hms()
                  .format(DateTime.parse(date).subtract(Duration(hours: 3))),
              style: TextStyle(
                  color:
                      tag == 'car' ? Colors.black : Colors.white), //aqui muda
            ),
          ],
        ),
        trailing: null,
      ),
    );
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
            ? Color(0xfff5f5f5)
            : Theme.of(context).colorScheme.secondary, //aqui muda
        elevation: 5,
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: ListTile(
          leading: SizedBox(
            //width: 85,
            height: 55,
            child: Card(
              //color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
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
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                    child: tag == 'car'
                        ? Icon(
                            Icons.directions_car, //aqui muda
                            color: Colors.black, //aqui muda
                            size: 50,
                          )
                        : Icon(
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
              color: tag == 'car' ? Colors.black : Colors.white, //aqui muda
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
                    color:
                        tag == 'car' ? Colors.black : Colors.white), //aqui muda
              ),
              Text(
                // widget.informationLogs[index].date,
                DateFormat.MMMMEEEEd('pt_BR')
                    .add_Hms()
                    .format(DateTime.parse(date).subtract(Duration(hours: 3))),
                style: TextStyle(
                    color:
                        tag == 'car' ? Colors.black : Colors.white), //aqui muda
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
      //physics: AlwaysScrollableScrollPhysics(),
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
    return widget.informationLogs.isEmpty
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
                    'Log de segurança vazio',
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
        : RefreshIndicator(
            onRefresh: () {
              return Future.delayed(Duration(seconds: 1), () {
                setState(() {});
              });
            },
            child: animatedList(),
          );
  }
}

// AnimatedList aniList() {
//   return AnimatedList(
//     initialItemCount: SEGURANCA_DATA.length,
//     itemBuilder: (context, index, animation) {
//       return 
//     },
//   );
// }

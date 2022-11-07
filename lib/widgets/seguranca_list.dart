import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../models/seguranca.dart';

class SegurancaList extends StatefulWidget {
  List<Seguranca> informationLogs;

  SegurancaList(this.informationLogs);

  @override
  State<SegurancaList> createState() => _SegurancaListState();
}

class _SegurancaListState extends State<SegurancaList> {
  late TextEditingController inputController;
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
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: widget.informationLogs.length,
              itemBuilder: (ctx, index) {
                return widget.informationLogs[index].tag != 'tag'
                    ? Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Color(0xfff5f5f5),
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
                                  child: Icon(
                                    Icons.directions_car,
                                    color: Colors.black,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            widget.informationLogs[index].title,
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
                                widget.informationLogs[index].info,
                              ),
                              Text(
                                // widget.informationLogs[index].date,
                                DateFormat.MMMMEEEEd('pt_BR').add_Hms().format(
                                    DateTime.parse(
                                            widget.informationLogs[index].date)
                                        .subtract(Duration(hours: 3))),
                              ),
                            ],
                          ),
                          trailing: null,
                        ),
                      )
                    : Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Theme.of(context).colorScheme.secondary,
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
                                  child: Icon(
                                    Icons.tag,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            widget.informationLogs[index].title,
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
                                widget.informationLogs[index].info,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                // widget.informationLogs[index].date,
                                DateFormat.MMMEd('pt_BR').add_Hms().format(
                                    DateTime.parse(
                                            widget.informationLogs[index].date)
                                        .subtract(Duration(hours: 3))),
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          trailing: null, //IconButton(
                          //   padding: EdgeInsets.zero,
                          //   constraints: BoxConstraints(),
                          //   onPressed: () async {
                          //     final userInput = await openDialog();
                          //     if (userInput == null || userInput.isEmpty)
                          //       return;
                          //     setState(() {
                          //       this.userInput = userInput;
                          //     });
                          //   },
                          //   icon: Icon(
                          //     Icons.report,
                          //     color: Colors.red,
                          //   ),
                          // ),
                        ),
                      );
              },
            ),
          );
  }
}

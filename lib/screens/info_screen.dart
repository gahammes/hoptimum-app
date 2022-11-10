import 'package:flutter/material.dart';

import '../models/hotel.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  static const routeName = '/info-screen';

  @override
  Widget build(BuildContext context) {
    const fontSize = 22.0;
    const fontSize1 = 18.0;
    final fontColor = Colors.white;
    final fontColorTitle = Theme.of(context).colorScheme.primary;
    Widget separator = const SizedBox(
      height: 25,
    );
    Widget divider = Divider(
      height: 30,
      thickness: 1.5,
      color: Theme.of(context).colorScheme.primary,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Informações'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Container(
        // padding: const EdgeInsets.only(
        //   top: 15,
        //   right: 15,
        //   left: 15,
        //   bottom: 15,
        // ),
        //margin: const EdgeInsets.only(bottom: 30.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Theme.of(context).colorScheme.secondary,
          elevation: 10.0,
          margin: const EdgeInsets.only(
            bottom: 90,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome',
                  style: TextStyle(
                      color: fontColorTitle,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize),
                ),
                Text('   ${hotelDados[0].nome}',
                    style: TextStyle(
                      fontSize: fontSize1,
                      color: fontColor,
                    )),
                separator,
                Text(
                  'Localizacao',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: fontColorTitle,
                  ),
                ),
                Text('   ${hotelDados[0].local}',
                    style: TextStyle(
                      fontSize: fontSize1,
                      color: fontColor,
                    )),
                separator,
                Text(
                  'Contato',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: fontColorTitle,
                  ),
                ),
                Text('   ${hotelDados[0].telefone}',
                    style: TextStyle(
                      fontSize: fontSize1,
                      color: fontColor,
                    )),
                Text('   ${hotelDados[0].email}',
                    style: TextStyle(
                      fontSize: fontSize1,
                      color: fontColor,
                    )),
                separator,
                Text(
                  'Horários',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: fontColorTitle,
                  ),
                ),
                Text('   ${hotelDados[0].horariosRef[0]}',
                    style: TextStyle(
                      fontSize: fontSize1,
                      color: fontColor,
                    )),
                Text('   ${hotelDados[0].horariosRef[1]}',
                    style: TextStyle(
                      fontSize: fontSize1,
                      color: fontColor,
                    )),
                Text('   ${hotelDados[0].horariosRef[2]}',
                    style: TextStyle(
                      fontSize: fontSize1,
                      color: fontColor,
                    )),
                divider,
                Text('   ${hotelDados[0].horariosLaz[0]}',
                    style: TextStyle(
                      fontSize: fontSize1,
                      color: fontColor,
                    )),
                Text('   ${hotelDados[0].horariosLaz[1]}',
                    style: TextStyle(
                      fontSize: fontSize1,
                      color: fontColor,
                    )),
                Text('   ${hotelDados[0].horariosLaz[2]}',
                    style: TextStyle(
                      fontSize: fontSize1,
                      color: fontColor,
                    )),
                divider,
                Text('   ${hotelDados[0].horariosServ[0]}',
                    style: TextStyle(
                      fontSize: fontSize1,
                      color: fontColor,
                    )),
                // Text('   ${hotelDados[0].horariosServ[1]}',
                //     style: TextStyle(
                //       fontSize: fontSize1,
                //       color: fontColor,
                //     )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

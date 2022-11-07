import 'package:dashboard_tcc/models/data/hotel_data.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  static const routeName = '/info-screen';

  @override
  Widget build(BuildContext context) {
    const fontSize = 22.0;
    const fontSize1 = 18.0;
    final fontColor = Theme.of(context).colorScheme.secondary;
    final fontColorTitle = Theme.of(context).colorScheme.primary;
    Widget separator = SizedBox(
      height: 25,
    );
    Widget divider = Divider(
      height: 30,
      color: Theme.of(context).colorScheme.primary,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Informações'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
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
            Text(HOTEL_DATA[0].nome,
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
            Text(HOTEL_DATA[0].local,
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
            Text(HOTEL_DATA[0].telefone,
                style: TextStyle(
                  fontSize: fontSize1,
                  color: fontColor,
                )),
            Text(HOTEL_DATA[0].email,
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
            Text(HOTEL_DATA[0].horariosRef[0],
                style: TextStyle(
                  fontSize: fontSize1,
                  color: fontColor,
                )),
            Text(HOTEL_DATA[0].horariosRef[1],
                style: TextStyle(
                  fontSize: fontSize1,
                  color: fontColor,
                )),
            Text(HOTEL_DATA[0].horariosRef[2],
                style: TextStyle(
                  fontSize: fontSize1,
                  color: fontColor,
                )),
            divider,
            Text(HOTEL_DATA[0].horariosLaz[0],
                style: TextStyle(
                  fontSize: fontSize1,
                  color: fontColor,
                )),
            Text(HOTEL_DATA[0].horariosLaz[1],
                style: TextStyle(
                  fontSize: fontSize1,
                  color: fontColor,
                )),
            Text(HOTEL_DATA[0].horariosLaz[2],
                style: TextStyle(
                  fontSize: fontSize1,
                  color: fontColor,
                )),
            divider,
            Text(HOTEL_DATA[0].horariosServ[0],
                style: TextStyle(
                  fontSize: fontSize1,
                  color: fontColor,
                )),
            Text(HOTEL_DATA[0].horariosServ[1],
                style: TextStyle(
                  fontSize: fontSize1,
                  color: fontColor,
                )),
          ],
        ),
      ),
    );
  }
}

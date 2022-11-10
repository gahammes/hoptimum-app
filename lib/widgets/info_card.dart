import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../models/hotel.dart';
import '../globals.dart' as globals;

const String _heroInfoCard = 'info-card-hero';

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key}) : super(key: key);

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
    return Hero(
      tag: globals.heroInfoCard,
      child: Material(
        type: MaterialType.transparency,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Theme.of(context).colorScheme.secondary,
          //elevation: 10.0,
          margin: const EdgeInsets.symmetric(
            vertical: 120,
            horizontal: 40,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AutoSizeText(
                    'Nome',
                    style: TextStyle(
                        color: fontColorTitle,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize),
                  ),
                ),
                Expanded(
                  child: AutoSizeText('   ${hotelDados[0].nome}',
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                Expanded(child: separator),
                Expanded(
                  child: AutoSizeText(
                    'Localizacao',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                      color: fontColorTitle,
                    ),
                  ),
                ),
                Expanded(
                  child: AutoSizeText('   ${hotelDados[0].local}',
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                Expanded(child: separator),
                Expanded(
                  child: AutoSizeText(
                    'Contato',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                      color: fontColorTitle,
                    ),
                  ),
                ),
                Expanded(
                  child: AutoSizeText('   ${hotelDados[0].telefone}',
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                Expanded(
                  child: AutoSizeText('   ${hotelDados[0].email}',
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                Expanded(child: separator),
                Expanded(
                  child: AutoSizeText(
                    'Horários',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                      color: fontColorTitle,
                    ),
                  ),
                ),
                Expanded(
                  child: AutoSizeText('   ${hotelDados[0].horariosRef[0]}',
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                Expanded(
                  child: AutoSizeText('   ${hotelDados[0].horariosRef[1]}',
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                Expanded(
                  child: AutoSizeText('   ${hotelDados[0].horariosRef[2]}',
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                Expanded(child: divider),
                Expanded(
                  child: AutoSizeText('   ${hotelDados[0].horariosLaz[0]}',
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                Expanded(
                  child: AutoSizeText('   ${hotelDados[0].horariosLaz[1]}',
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                Expanded(
                  child: AutoSizeText('   ${hotelDados[0].horariosLaz[2]}',
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                Expanded(child: divider),
                Expanded(
                  child: AutoSizeText('   ${hotelDados[0].horariosServ[0]}',
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
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

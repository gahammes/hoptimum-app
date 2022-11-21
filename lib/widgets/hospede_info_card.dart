import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../models/quarto.dart';
import '../globals.dart' as globals;
import 'package:auto_size_text/auto_size_text.dart';

class HospedeInfoCard extends StatelessWidget {
  final String tag;
  final Map hospede;
  final bool titular;
  const HospedeInfoCard(this.tag, this.hospede, this.titular, {Key? key})
      : super(key: key);

  int getIndex() {
    var dados = globals.loginData as Map;
    var reservas = [];

    reservas = dados['hospede']['reservas'];
    int index = reservas.indexWhere((reserva) {
      Map mapa = reserva as Map;
      if (mapa['reserva']['status'].toString().toLowerCase() == 'ativa') {
        return true;
      } else {
        return false;
      }
    });
    //print('INDEX DA RESERVA ATIVA $index');
    return index;
  }

  // List getHospedes() {
  //   var hospedes = [];
  //   hospedes = globals.loginData['hospede']['reservas'][getIndex()]['reserva']
  //       ['hospedes'];
  //   return hospedes;
  // }

  List getCarros() {
    return globals.loginData['hospede']['carros'];
  }

  Map getReservaInfo() {
    var dados = globals.loginData as Map;
    return dados['hospede']['reservas'][getIndex()]['reserva'];
  }

  Quarto getQuartoInfo() {
    switch (getReservaInfo()['quarto']['nome'].toString().toLowerCase()) {
      case 'quarto top':
        return quartosList.firstWhere((quarto) => quarto.nome == 'Family Room');
      case 'quarto nao tao top':
        return quartosList.firstWhere((quarto) => quarto.nome == 'Double Room');
      case 'quarto lixo':
        return quartosList.firstWhere((quarto) => quarto.nome == 'Single Room');
      default:
        return quartosList[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
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
      tag: tag,
      child: Material(
        type: MaterialType.transparency,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Theme.of(context).colorScheme.secondary,
          //elevation: 10.0,
          margin: const EdgeInsets.symmetric(
            vertical: 180,
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
                  child: AutoSizeText(hospede['nome'],
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                Expanded(child: separator),
                Expanded(
                  child: AutoSizeText(
                    'Email',
                    style: TextStyle(
                        color: fontColorTitle,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize),
                  ),
                ),
                Expanded(
                  child: AutoSizeText(hospede['email'],
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                Expanded(child: separator),
                Expanded(
                  child: AutoSizeText(
                    'CPF',
                    style: TextStyle(
                        color: fontColorTitle,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize),
                  ),
                ),
                Expanded(
                  child: AutoSizeText(hospede['cpf'],
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                Expanded(child: separator),
                Expanded(
                  child: AutoSizeText(
                    'Telefone',
                    style: TextStyle(
                        color: fontColorTitle,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize),
                  ),
                ),
                Expanded(
                  child: AutoSizeText(hospede['telefone'],
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                Expanded(child: separator),
                Expanded(
                  child: AutoSizeText(
                    'Data de Nascimento',
                    style: TextStyle(
                        color: fontColorTitle,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize),
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                      DateFormat.yMMMMd('pt_BR')
                          .format(DateTime.parse(hospede['nascimento'])),
                      style: TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                if (titular) Expanded(child: separator),
                if (titular)
                  Expanded(
                    child: AutoSizeText(
                      'Carros',
                      style: TextStyle(
                          color: fontColorTitle,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize),
                    ),
                  ),
                if (titular)
                  for (var i = 0; i < getCarros().length; i++)
                    Expanded(
                      child: AutoSizeText(
                          'Modelo: ${getCarros()[i]['modelo']}  /  Placa${getCarros()[i]['placa']}',
                          style: TextStyle(
                            fontSize: fontSize1,
                            color: fontColor,
                          )),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

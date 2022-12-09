import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../models/quarto.dart';
import '../globals.dart' as globals;

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
    return index;
  }

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
    const fontColor = Colors.white;
    final fontColorTitle = Theme.of(context).colorScheme.primary;
    Widget separator = const SizedBox(
      height: 25,
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
                      style: const TextStyle(
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
                      style: const TextStyle(
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
                      style: const TextStyle(
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
                      style: const TextStyle(
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
                      style: const TextStyle(
                        fontSize: fontSize1,
                        color: fontColor,
                      )),
                ),
                if (titular && getCarros().isNotEmpty)
                  Expanded(child: separator),
                if (titular && getCarros().isNotEmpty)
                  Expanded(
                    child: AutoSizeText(
                      'Carros',
                      style: TextStyle(
                          color: fontColorTitle,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize),
                    ),
                  ),
                if (titular && getCarros().isNotEmpty)
                  for (var i = 0; i < getCarros().length; i++)
                    Expanded(
                      child: AutoSizeText(
                          'Modelo: ${getCarros()[i]['modelo']}  /  Placa: ${getCarros()[i]['placa']}',
                          style: const TextStyle(
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

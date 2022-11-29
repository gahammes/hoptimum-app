import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../models/quarto.dart';
import '../globals.dart' as globals;

class ReservaInfoCard extends StatelessWidget {
  const ReservaInfoCard({Key? key}) : super(key: key);

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

  Row buildWrappedText(String title, String subtitle) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Quicksand',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: FittedBox(
            child: Text(
              subtitle,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Quicksand',
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRichText(String title, String subtitle) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            fontSize: 16, fontFamily: 'Quicksand', color: Colors.black),
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: subtitle,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Hero(
      tag: globals.heroReservaInfoCard,
      child: Material(
        type: MaterialType.transparency,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 2,
          margin: const EdgeInsets.symmetric(
            vertical: 175,
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  child: Image.network(
                    getQuartoInfo().url,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getQuartoInfo().nome,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getQuartoInfo().tipo,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'R\$${getReservaInfo()['quarto']['precoBase'].toStringAsFixed(0)}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                ' / noite',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 10),
                      _buildRichText(
                        'Número do quarto: ',
                        getReservaInfo()['quarto']['numero'].toString(),
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 10),
                      buildWrappedText('Número da reserva: ',
                          getReservaInfo()['_id'].toString()),
                      buildWrappedText(
                        'Data da reserva: ',
                        DateFormat.yMMMMd('pt_BR').format(
                            DateTime.parse(getReservaInfo()['createdAt'])),
                      ),
                      buildWrappedText(
                        'Data do check-in: ',
                        DateFormat.yMMMMd('pt_BR').format(
                            DateTime.parse(getReservaInfo()['checkIn'])),
                      ),
                      buildWrappedText(
                        'Data do check-out: ',
                        DateFormat.yMMMMd('pt_BR').format(
                            DateTime.parse(getReservaInfo()['checkOut'])),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

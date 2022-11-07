import 'package:dashboard_tcc/models/hospede.dart';
import 'package:dashboard_tcc/models/quarto.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';

class ReservaInfo extends StatelessWidget {
  final Reserva reserva;
  final Quarto quarto;
  ReservaInfo({required this.reserva, required this.quarto});
  static const routeName = '/reserva-info-screen';

  Widget _buildRichText(String title, String subtitle) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
            fontSize: 16, fontFamily: 'Quicksand', color: Colors.black),
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: subtitle),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Reserva'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Column(
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 2,
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      child: Image.network(
                        quarto.url,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                    bottom: 10,
                  ),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quarto.nome,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                quarto.tipo,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'R\$${quarto.preco.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
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
                          SizedBox(height: 10),
                          Divider(
                            height: 2,
                            thickness: 1,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRichText(
                                'Número do quarto: ',
                                reserva.quarto.toString(),
                              ),
                              _buildRichText(
                                'Códigos dos cartões-chave: ',
                                '2261, 2262',
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(
                            height: 2,
                            thickness: 1,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRichText(
                                'Número da reserva: ',
                                reserva.numReserva.toString(),
                              ),
                              _buildRichText(
                                'Data da reserva: ',
                                DateFormat.yMMMMd('pt_BR')
                                    .format(reserva.dataReserva),
                              ),
                              _buildRichText(
                                'Data do check-in: ',
                                DateFormat.yMMMMd('pt_BR')
                                    .format(reserva.dataCheckIn),
                              ),
                              _buildRichText(
                                'Data do check-out: ',
                                DateFormat.yMMMMd('pt_BR')
                                    .format(reserva.dataCheckOut),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

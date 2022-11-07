import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dashboard_tcc/models/data/despesas_data.dart';
import 'package:dashboard_tcc/models/hospede.dart';
import 'package:dashboard_tcc/screens/info_sceen.dart';
import 'package:dashboard_tcc/screens/reserva_info.dart';
import 'package:dashboard_tcc/widgets/cards_list.dart';
import 'package:dashboard_tcc/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../globals.dart' as globals;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _selectInfo(BuildContext context) {
    Navigator.of(context).pushNamed(InfoScreen.routeName);
  }

  void _selectReservaInfo(BuildContext context) {
    Navigator.of(context).pushNamed(ReservaInfo.routeName);
  }

  int getHospCount() {
    //var hospCount;
    //var decodedData;

    var hospedes = [];

    hospedes = globals.loginData['hospede']['reservas'][getIndex()]['reserva']
        ['hospedes'];
    //print('numero hospedes ${hospedes.length}');

    return hospedes.length;
  }

  List getReservas() {
    var reservas = [];
    reservas = globals.loginData['hospede']['reservas'];
    return reservas;
  }

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

  String getNome(int index) {
    return getHospedes()[index]['hospede']['nome'].toString();
  }

  String getQuarto(int index) {
    return getReservas()[getIndex()]['reserva']['quarto']['numero'].toString();
  }

  bool getTitular(int index) {
    if (globals.loginData['hospede']['reservas'][getIndex()]['reserva']
            ['hospedes'][index]['titular'] ==
        true) {
      return true;
    }
    return false;
  }

  List getHospedes() {
    var hospedes = [];
    hospedes = globals.loginData['hospede']['reservas'][getIndex()]['reserva']
        ['hospedes'];
    return hospedes;
  }

  double _getConsumo() {
    var subTotal = 0.0;
    for (var valor in DESPESAS_DATA)
      !valor.title.contains('Diária')
          ? subTotal += valor.amount
          : subTotal += 0;
    return subTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          //margin: EdgeInsets.only(top: 5),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/LogoFinal.png'),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  top: 10,
                ),
                child: Text(
                  'H\'Optimum',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Gabriola',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        //SizedBox(height: height * 0.03),
        Container(
          //height: 230,
          child: CarouselSlider(
            //TODO: IMPLEMENTAR BUILDER
            options: CarouselOptions(
              enableInfiniteScroll: getHospCount() > 1 ? true : false,
              autoPlay: false,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            items: [
              for (var i = 0; i < getHospCount(); i++)
                CardsList(
                    getNome(i),
                    getTitular(i) == true ? 'Titular' : 'Dependente',
                    'Quarto ${getQuarto(i)}',
                    ''),
            ],
          ),
        ),
        Container(
          //height: 200,
          child: Column(
            //padding: EdgeInsets.all(0),
            children: [
              FittedBox(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => _selectInfo(context),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10, top: 0),
                        height: 160,
                        width: 180,
                        padding: EdgeInsets.only(left: 20, right: 0, bottom: 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50.0),
                              topLeft: Radius.circular(10.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.3),
                                offset: Offset(-10.0, 0.0),
                                blurRadius: 20.0,
                                spreadRadius: 4.0,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(
                            left: 10,
                            top: 40,
                            bottom: 20,
                            right: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'INFORMAÇÕES',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Toque para saber mais informações sobre o hotel e horários.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.right,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 0),
                      height: 160,
                      width: 200,
                      padding: EdgeInsets.only(left: 20, right: 15, bottom: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.3),
                              offset: Offset(-10.0, 0.0),
                              blurRadius: 20.0,
                              spreadRadius: 4.0,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.only(
                          left: 15,
                          top: 40,
                          bottom: 20,
                          right: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //TODO:COISO AQUI CONSUMO
                            Text(
                              'CONSUMO',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'R\$ ${_getConsumo().toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    //fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Mais detalhes na aba de despesas.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    //fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => _selectReservaInfo(context),
                child: Container(
                  margin: EdgeInsets.only(bottom: 10, top: 30),
                  height: 100,
                  width: 385,
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.3),
                          offset: Offset(-10.0, 0.0),
                          blurRadius: 20.0,
                          spreadRadius: 4.0,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(
                      left: 5,
                      top: 15,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${HOSPEDES[2].reserva.dataCheckOut.difference(DateTime.now()).inDays.toString()} dias para o check-out'
                              .toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Text(
                          'Toque para conferir as informações da sua reserva!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

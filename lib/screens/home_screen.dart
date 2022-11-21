import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../models/despesa.dart';
import '../screens/tabs_screen.dart';
import '../widgets/custom_rect_tween.dart';
import '../widgets/hero_dialog_route.dart';
import '../widgets/info_card.dart';
import '../widgets/reserva_info_card.dart';

import '../widgets/cards_list.dart';
import '../widgets/gradient_text.dart';
import '../globals.dart' as globals;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  DateTime getDatas(String qual) {
    var reservas = globals.loginData as Map;
    return qual == 'checkIn'
        ? DateTime.parse(
            reservas['hospede']['reservas'][getIndex()]['reserva']['checkIn'])
        : DateTime.parse(
            reservas['hospede']['reservas'][getIndex()]['reserva']['checkOut']);
  }

  void printReserva() {
    var reservas = globals.loginData as Map;
    print(
        reservas['hospede']['reservas'][getIndex()]['reserva']['servicos'][0]);
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

  void getCartoes() {
    var cartoes = [];
    cartoes = globals.loginData['hospede']['reservas'][getIndex()]['reserva']
        ['cartoesChave'];
    print(cartoes);
  }

  double _getConsumo() {
    var subTotal = 0.0;
    for (var valor in despesasLog) {
      !valor.title.contains('Diária')
          ? subTotal += valor.amount
          : subTotal += 0;
    }
    return subTotal;
  }

  // void printCarros() {
  @override
  Widget build(BuildContext context) {
    var gradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.fromARGB(255, 255, 135, 108),
        Color.fromARGB(255, 248, 128, 101),
        Color.fromARGB(255, 246, 106, 75),
        Color(0xffF75E3B),
      ],
      stops: [0.1, 0.4, 0.7, 0.9],
    );

    var textStyle = TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontSize: 17,
      fontWeight: FontWeight.bold,
    );
    // printCarros();
    //printReserva();
    return Column(
      children: [
        Container(
          height: 90,
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: const Image(
                    image: AssetImage('assets/images/new_logo.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
        //SizedBox(height: height * 0.03),
        CarouselSlider(
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
                'Clique para informações',
                'hosp-info-hero$i',
                getHospedes()[i]['hospede'],
                getTitular(i),
              ),
          ],
        ),
        Column(
          //padding: EdgeInsets.all(0),
          children: [
            FittedBox(
              child: Row(
                children: [
                  GestureDetector(
                    //onTap: () => _selectInfo(context),
                    onTap: () {
                      Navigator.of(context).push(
                        HeroDialogRoute(builder: (context) {
                          return const InfoCard();
                        }),
                      );
                    },
                    child: Hero(
                      tag: globals.heroInfoCard,
                      createRectTween: (begin, end) {
                        return CustomRectTween(begin: begin!, end: end!);
                      },
                      child: Material(
                        type: MaterialType.transparency,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 0),
                          height: 160,
                          width: 180,
                          padding: const EdgeInsets.only(
                              left: 20, right: 0, bottom: 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50.0),
                                topLeft: Radius.circular(10.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.3),
                                  offset: const Offset(-10.0, 0.0),
                                  blurRadius: 20.0,
                                  spreadRadius: 4.0,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 40,
                              bottom: 20,
                              right: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Material(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  child: GradientText(
                                    'INFORMAÇÕES',
                                    gradient: gradient,
                                    style: textStyle,
                                  ),
                                ),
                                // Text(
                                //   'INFORMAÇÕES',
                                //   style: TextStyle(
                                //     color: Theme.of(context).colorScheme.primary,
                                //     fontSize: 17,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Material(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  child: const Text(
                                    'Toque para saber mais informações sobre o hotel e horários.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: getDatas('checkIn').isAfter(DateTime.now())
                        ? null
                        : () {
                            setState(() {
                              globals.tabIndex = 1;
                            });
                            Navigator.of(context)
                                .pushReplacementNamed(TabsScreen.routeName);
                          },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 0),
                      height: 160,
                      width: 200,
                      padding:
                          const EdgeInsets.only(left: 20, right: 15, bottom: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.3),
                              offset: const Offset(-10.0, 0.0),
                              blurRadius: 20.0,
                              spreadRadius: 4.0,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 40,
                          bottom: 20,
                          right: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText(
                              'CONSUMO',
                              gradient: gradient,
                              style: textStyle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'R\$ ${_getConsumo().toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    //fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  getDatas('checkIn').isAfter(DateTime.now())
                                      ? 'Disponibilizado após o check-in.'
                                      : 'Mais detalhes na aba de despesas.',
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
                  ),
                ],
              ),
            ),
            GestureDetector(
              //onTap: () => _selectReservaInfo(context),
              onTap: () {
                Navigator.of(context).push(
                  HeroDialogRoute(builder: (context) {
                    return const ReservaInfoCard();
                  }),
                );
              },
              child: Hero(
                tag: globals.heroReservaInfoCard,
                createRectTween: (begin, end) {
                  return CustomRectTween(begin: begin!, end: end!);
                },
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 30),
                    height: 100,
                    width: 385,
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.3),
                            offset: const Offset(-10.0, 0.0),
                            blurRadius: 20.0,
                            spreadRadius: 4.0,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(
                        left: 5,
                        top: 15,
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GradientText(
                            getDatas('checkIn').isAfter(DateTime.now())
                                ? '${getDatas('checkIn').difference(DateTime.now()).inDays.toString()} dias para o check-in'
                                    .toUpperCase()
                                : '${getDatas('checkOut').difference(DateTime.now()).inDays.toString()} dias para o check-out'
                                    .toUpperCase(),
                            gradient: gradient,
                            style: textStyle,
                          ),
                          // Text(
                          //   '${getDatas('checkOut').difference(getDatas('checkIn')).inDays.toString()} dias para o check-out'
                          //       .toUpperCase(),
                          //   style: TextStyle(
                          //     color: Theme.of(context).colorScheme.primary,
                          //     fontSize: 17,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          //   textAlign: TextAlign.center,
                          // ),
                          const SizedBox(
                            height: 9,
                          ),
                          const Text(
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
                //aqui
              ),
            ),
          ],
        ),
      ],
    );
  }
}

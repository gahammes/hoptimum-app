import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hoptimum/models/providers/auth.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/quarto.dart';
import '../globals.dart' as globals;

class CancelarReservaScreen extends StatefulWidget {
  const CancelarReservaScreen({Key? key}) : super(key: key);
  static const routeName = 'cancelar-reserva-screen';

  @override
  State<CancelarReservaScreen> createState() => _CancelarReservaScreenState();
}

class _CancelarReservaScreenState extends State<CancelarReservaScreen> {
  var _isLoading = false;
  var _confirmarCancelamento = false;
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

  Widget _buildCancelarReservaButton() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 20,
      ),
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: cancelarReserva,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                'Cancelar reserva'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          elevation: MaterialStateProperty.all(5.0),
          padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
          backgroundColor: MaterialStateProperty.all(Colors.red),
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
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
                    DateFormat.yMMMMd('pt_BR')
                        .format(DateTime.parse(getReservaInfo()['createdAt'])),
                  ),
                  buildWrappedText(
                    'Data do check-in: ',
                    DateFormat.yMMMMd('pt_BR')
                        .format(DateTime.parse(getReservaInfo()['checkIn'])),
                  ),
                  buildWrappedText(
                    'Data do check-out: ',
                    DateFormat.yMMMMd('pt_BR')
                        .format(DateTime.parse(getReservaInfo()['checkOut'])),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget confirmarCancelamentoButton(BuildContext ctx) {
    return TextButton(
      child: const Text("Confirmar"),
      onPressed: () {
        setState(() {
          _confirmarCancelamento = true;
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget fecharButton(BuildContext ctx) {
    return TextButton(
      child: const Text("Fechar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  AlertDialog confirmarReservaDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const FittedBox(
        child: Text(
          "Confirme o cancelamento!",
          style: TextStyle(color: Colors.black),
        ),
      ),
      //contentTextStyle: TextStyle(),
      content: const Text(
        "Clique em confirmar para cancelar sua reserva.",
      ),
      actions: [
        fecharButton(context),
        confirmarCancelamentoButton(context),
      ],
    );
  }

  void _logout() {
    Provider.of<Auth>(context, listen: false).logout();
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed('/');
  }

  void cancelarReserva() async {
    setState(() {
      _isLoading = true;
    });
    await showDialog(context: context, builder: confirmarReservaDialog);
    if (!_confirmarCancelamento) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      final url = Uri.parse(globals.getUrl('http', 'api/updatereserva'));
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'id': getReservaInfo()['_id'],
            'update': 'cancelada',
          },
        ),
      );
      var res = json.decode(response.body) as Map;
      print('😶‍🌫️ $res');
      //globals.carrosArray.add(res['_id']);
    } catch (error) {
      print(error);
    }
    setState(() {
      _isLoading = false;
    });
    _logout();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          _buildCard(),
          _buildCancelarReservaButton(),
        ],
      ),
    );
  }
}

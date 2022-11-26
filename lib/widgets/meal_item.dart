import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hoptimum/models/despesa.dart';
import 'package:hoptimum/models/notificacao.dart';
import 'package:http/http.dart' as http;

import '../globals.dart' as globals;

class RefeicaoItem extends StatefulWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final double price;

  const RefeicaoItem({
    Key? key,
    required this.id,
    required this.duration,
    required this.imageUrl,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  State<RefeicaoItem> createState() => _RefeicaoItemState();
}

class _RefeicaoItemState extends State<RefeicaoItem> {
  var _isLoading = false;
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

  List getReservas() {
    var reservas = [];
    reservas = globals.loginData['hospede']['reservas'];
    return reservas;
  }

  String getReservaId() {
    return getReservas()[getIndex()]['reserva']['_id'].toString();
  }

  Widget fecharButton(BuildContext ctx) {
    return TextButton(
      child: const Text("Fechar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  AlertDialog pedidoFeitoDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Confirmado",
        style: TextStyle(color: Colors.black),
      ),
      content: const Text("Pedido recebido!"),
      actions: [
        fecharButton(context),
      ],
    );
  }

  void fazerPedido() async {
    setState(() {
      _isLoading = true;
    });

    var url = Uri.parse(globals.getUrl('http', 'api/servico'));
    try {
      var res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'idServico': widget.id,
          'idReserva': getReservaId(),
        }),
      );
      var data = json.decode(res.body);
      Despesa newDespesa = Despesa(
        id: widget.id,
        title: widget.title,
        amount: widget.price,
        date: DateTime.parse(data['createdAt'].toString())
            .subtract(const Duration(hours: 3)),
      );
      setState(() {
        despesasLog.insert(0, newDespesa);
        notificacoes.insert(
          0,
          Notificacao(
            id: widget.id,
            title: widget.title,
            status: 'Em espera',
            date: DateTime.now(),
            tag: widget.title.toLowerCase() == 'serviço de quarto'
                ? 'serv'
                : 'ref',
          ),
        );
      });

      print('🤦‍♂️ $data');
      setState(() {
        _isLoading = false;
      });
      showDialog(context: context, builder: pedidoFeitoDialog);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Confirmar"),
      onPressed: () {
        Navigator.of(context).pop();
        fazerPedido();
      },
    );
    // set up the AlertDialog
    AlertDialog confirmacaoDialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Confirmação",
        style: TextStyle(color: Colors.black),
      ),
      content: const Text("Quer fazer esse pedido?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    final iconColor = Theme.of(context).colorScheme.primary;
    const fontColor = Colors.white;
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  widget.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 5,
                child: Container(
                  width: 300,
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: 10,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: iconColor,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          '${widget.duration} min',
                          style: const TextStyle(
                            color: fontColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 0),
                    //   child: affordabilityIcons(context),
                    // ),
                    Row(
                      children: [
                        Text(
                          'R\$ ',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          widget.price.toStringAsFixed(2),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return confirmacaoDialog;
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'PEDIR',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
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

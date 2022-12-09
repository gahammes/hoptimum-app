// ignore_for_file: must_be_immutable, must_call_super
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/pedido.dart';
import '../globals.dart' as globals;

class FuncSolicitacaoItem extends StatefulWidget {
  final String id;
  final String title;
  final String quarto;
  final DateTime data;
  Status status;
  FuncSolicitacaoItem(this.id, this.title, this.quarto, this.data, this.status,
      {Key? key})
      : super(key: key);
  @override
  State<FuncSolicitacaoItem> createState() => _FuncSolicitacaoItemState();
}

class _FuncSolicitacaoItemState extends State<FuncSolicitacaoItem>
    with AutomaticKeepAliveClientMixin<FuncSolicitacaoItem> {
  @override
  bool get wantKeepAlive => true;

  void _updateStatus() async {
    var status = '';
    setState(() {
      switch (widget.status) {
        case Status.espera:
          widget.status = Status.recebido;
          status = 'recebido';
          break;
        case Status.recebido:
          widget.status = Status.preparando;
          status = 'preparando';
          break;
        case Status.preparando:
          widget.status = Status.caminho;
          status = 'caminho';
          break;
        case Status.caminho:
          widget.status = Status.entregue;
          status = 'entregue';
          break;
        case Status.entregue:
          widget.status = Status.finalizado;
          status = 'finalizado';
          pedidosList.removeWhere((pedido) => pedido.id == widget.id);
          break;
        case Status.finalizado:
          break;
        default:
          break;
      }
    });
    try {
      final url = Uri.parse(globals.getUrl('http', 'api/statusservico'));
      await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'id': widget.id,
            'status': status,
          },
        ),
      );
    } catch (error) {
      //print(error);
    }
  }

  Widget _buildExpansionTile(Color color) {
    return ExpansionTile(
      collapsedBackgroundColor: const Color(0xfff5f5f5),
      backgroundColor: const Color(0xfff5f5f5),
      title: const Text(
        'Detalhes',
        style: TextStyle(fontSize: 16),
      ),
      textColor: Theme.of(context).colorScheme.primary,
      childrenPadding:
          const EdgeInsets.only(left: 16.0, bottom: 10.0, right: 10.0),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
                fontSize: 16, fontFamily: 'Quicksand', color: Colors.black),
            children: [
              const TextSpan(
                text: 'Número do pedido: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: '${(widget.id.toString())}.'),
            ],
          ),
        ),
        const SizedBox(height: 7.0),
        RichText(
          text: TextSpan(
            style: const TextStyle(
                fontSize: 16, fontFamily: 'Quicksand', color: Colors.black),
            children: [
              const TextSpan(
                text: 'Refeição: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: '${(widget.title)}.'),
            ],
          ),
        ),
        const SizedBox(height: 7.0),
        RichText(
          text: TextSpan(
            style: const TextStyle(
                fontSize: 16, fontFamily: 'Quicksand', color: Colors.black),
            children: [
              const TextSpan(
                text: 'Data: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                  text: '${DateFormat.MMMMd('pt_BR').format(widget.data)}.'),
            ],
          ),
        ),
        const SizedBox(height: 7.0),
        RichText(
          text: TextSpan(
            style: const TextStyle(
                fontSize: 16, fontFamily: 'Quicksand', color: Colors.black),
            children: [
              const TextSpan(
                text: 'Hora: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: '${DateFormat.Hm('pt_BR').format(widget.data)}.'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getText(Color color) {
    switch (widget.status) {
      case Status.espera:
        return const Text('Pedido em espera...',
            style: TextStyle(color: Colors.red));
      case Status.recebido:
        return const Text('Pedido recebido',
            style: TextStyle(color: Colors.yellow));
      case Status.preparando:
        return const Text("Pedido em preparo",
            style: TextStyle(color: Colors.yellow));
      case Status.caminho:
        return const Text('Pedido à caminho',
            style: TextStyle(color: Colors.yellow));
      case Status.entregue:
        return const Text('Pedido entregue',
            style: TextStyle(color: Colors.green));
      case Status.finalizado:
        return Text('Pedido finalizado', style: TextStyle(color: color));
      default:
        return Text('Pedido em espera...', style: TextStyle(color: color));
    }
  }

  Widget _buildCard() {
    var bgColor = Theme.of(context).colorScheme.secondary;
    var fontColor = Colors.white;

    return Container(
      margin: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: bgColor,
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Column(
          children: [
            ListTile(
              leading: SizedBox(
                height: 60,
                child: Card(
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: FittedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 255, 135, 108),
                            Color.fromARGB(255, 248, 128, 101),
                            Color.fromARGB(255, 246, 106, 75),
                            Color(0xffF75E3B),
                          ],
                          stops: [0.1, 0.4, 0.7, 0.9],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      child: const Icon(
                        Icons.restaurant,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                'Quarto ${widget.quarto.toString()}',
                style: TextStyle(
                  color: fontColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: _getText(
                fontColor,
              ),
              trailing: widget.status != Status.finalizado
                  ? IconButton(
                      icon: const Icon(Icons.refresh),
                      color: Colors.white,
                      onPressed: _updateStatus,
                    )
                  : null,
            ),
            _buildExpansionTile(
              fontColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCard();
  }
}

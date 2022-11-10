import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/pedido.dart';

class FuncSolicitacaoItem extends StatefulWidget {
  final List<Pedido> pedidos;
  final List<Pedido> pedidosFinalizados;
  const FuncSolicitacaoItem(this.pedidos, this.pedidosFinalizados, {Key? key})
      : super(key: key);
  @override
  State<FuncSolicitacaoItem> createState() => _FuncSolicitacaoItemState();
}

class _FuncSolicitacaoItemState extends State<FuncSolicitacaoItem> {
  void _updateStatus(int index, int id) {
    setState(() {
      switch (widget.pedidos[index].status) {
        case Status.espera:
          widget.pedidos[index].status = Status.recebido;
          break;
        case Status.recebido:
          widget.pedidos[index].status = Status.preparando;
          break;
        case Status.preparando:
          widget.pedidos[index].status = Status.caminho;
          break;
        case Status.caminho:
          widget.pedidos[index].status = Status.entregue;
          break;
        case Status.entregue:
          widget.pedidos[index].status = Status.finalizado;
          widget.pedidosFinalizados.insert(0, widget.pedidos[index]);
          widget.pedidos.removeAt(index);
          break;
        case Status.finalizado:
          break;
        default:
          break;
      }
    });
  }

  Widget _buildExpansionTile(int index, Color color) {
    return ExpansionTile(
      //maintainState: true,
      collapsedBackgroundColor: const Color(0xfff5f5f5),
      backgroundColor: const Color(0xfff5f5f5),
      //collapsedBackgroundColor: Colors.white,
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
                text: 'Número do quarto: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: '${widget.pedidos[index].numQuarto.toString()}.'),
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
              TextSpan(
                  text:
                      '${DateFormat.Hm('pt_BR').format(widget.pedidos[index].data)}.'),
            ],
          ),
        ),
        const SizedBox(height: 7.0),
        _buildListRefeicao(index),
      ],
    );
  }

  Widget _buildListRefeicao(int index) {
    return widget.pedidos[index].refeicao.length == 1
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Refeição: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, bottom: 5.0),
                child: Text(
                  widget.pedidos[index].refeicao[0],
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Refeições: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              for (var refeicao in widget.pedidos[index].refeicao)
                Container(
                  margin: const EdgeInsets.only(left: 20.0, bottom: 5.0),
                  child: Text(
                    refeicao,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
            ],
          );
  }

  Widget _getText(int index, Color color) {
    switch (widget.pedidos[index].status) {
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

  Widget _buildCard(int index) {
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
                //width: 85,
                height: 60,
                child: Card(
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: FittedBox(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
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
                'Pedido ${widget.pedidos[index].id}',
                style: TextStyle(
                  color: fontColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: _getText(
                index,
                fontColor,
              ),
              trailing: widget.pedidos[index].status != Status.finalizado
                  ? IconButton(
                      icon: const Icon(Icons.refresh),
                      color: Colors.white,
                      onPressed: () =>
                          _updateStatus(index, widget.pedidos[index].id),
                    )
                  : null,
            ),
            _buildExpansionTile(
              index,
              fontColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 1), () {
          setState(() {});
        });
      },
      child: ListView.builder(
          itemCount: widget.pedidos.length,
          itemBuilder: (context, index) {
            return _buildCard(index);
          }),
    );
  }
}

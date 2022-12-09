import 'package:hoptimum/services/local_notification_service.dart';
import 'dart:math';

import '../globals.dart' as globals;

class Notificacao {
  final String id;
  final String title;
  final String status;
  final DateTime date;
  final String tag;

  const Notificacao({
    required this.id,
    required this.title,
    required this.status,
    required this.date,
    required this.tag,
  });
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
  return index;
}

void getPedidosHosp() {
  var tag = '';

  List servicos = globals.loginData['hospede']['reservas'][getIndex()]
      ['reserva']['servicos'];
  for (var i = 0; i < servicos.length; i++) {
    var mapa = servicos[i] as Map;
    if (mapa['servico']['nome'].toString().toLowerCase() !=
        'serviço de quarto') {
      tag = 'ref';
    } else {
      tag = 'serv';
    }
    notificacoes.insert(
      0,
      Notificacao(
        id: mapa['_id'],
        title: mapa['servico']['nome'],
        status: mapa['status'],
        date: DateTime.parse(mapa['updatedAt'].toString()),
        tag: tag,
      ),
    );
  }
  notificacoes.sort((a, b) {
    return -a.date.compareTo(b.date);
  });
}

String getStatusText(String status, String tag) {
  switch (status) {
    case 'espera':
      return tag == 'serv' ? 'Solicitação em espera...' : 'Pedido em espera...';

    case 'recebido':
      return tag == 'serv' ? 'Solicitação recebida.' : 'Pedido recebido.';
    case 'preparando':
      return tag == 'serv'
          ? 'Realizando serviço de quarto.'
          : "Pedido em preparo.";
    case 'caminho':
      return 'Pedido à caminho.';
    case 'entregue':
      return 'Pedido entregue.';
    case 'finalizado':
      return tag == 'serv' ? 'Solicitação finalizada.' : 'Pedido finalizado.';
    default:
      return 'Pedido em espera.';
  }
}

void updateStatus() {
  var nome = '';
  var tag = '';
  var rng = Random();
  List servicos = globals.loginData['hospede']['reservas'][getIndex()]
      ['reserva']['servicos'];
  for (var i = 0; i < servicos.length; i++) {
    var mapa = servicos[i] as Map;
    if (globals.newStatus['_id'] == mapa['_id']) {
      nome = mapa['servico']['nome'];
      if (nome.toLowerCase() != 'serviço de quarto') {
        tag = 'ref';
      } else {
        tag = 'serv';
      }
    }
  }
  LocalNotificationService().showNotification(
    rng.nextInt(999),
    nome,
    getStatusText(globals.newStatus['status'], tag),
  );
  notificacoes.insert(
    0,
    Notificacao(
      id: globals.newStatus['_id'],
      title: nome,
      status: globals.newStatus['status'],
      date: DateTime.parse(globals.newStatus['updatedAt'].toString()),
      tag: tag,
    ),
  );
  if (globals.listKeyNotif.currentState == null) {
  } else {
    globals.listKeyNotif.currentState!.insertItem(
      0,
      duration: const Duration(milliseconds: 350),
    );
  }
}

List<Notificacao> notificacoes = [];

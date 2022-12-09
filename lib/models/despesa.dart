import 'dart:math';

import '../globals.dart' as globals;

class Despesa {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String status;

  const Despesa({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    this.status = 'espera',
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

DateTime getDatas(String qual) {
  var reservas = globals.loginData as Map;
  return qual == 'checkIn'
      ? DateTime.parse(
          reservas['hospede']['reservas'][getIndex()]['reserva']['checkIn'])
      : DateTime.parse(
          reservas['hospede']['reservas'][getIndex()]['reserva']['checkOut']);
}

double getDiaria() {
  var reservas = globals.loginData as Map;
  return double.parse(reservas['hospede']['reservas'][getIndex()]['reserva']
          ['quarto']['precoBase']
      .toString());
}

void getDepesaLog() {
  var logs = [];

  logs = globals.loginData['hospede']['reservas'][getIndex()]['reserva']
      ['servicos'];

  for (var i = 0; i < logs.length; i++) {
    var logMap = logs[i] as Map;
    despesasLog.add(
      Despesa(
        id: logMap['_id'],
        title: logMap['servico']['nome'].toString(),
        amount: double.parse(logMap['servico']['preco'].toString()),
        date: DateTime.parse(logMap['createdAt'].toString())
            .subtract(const Duration(hours: 3)),
      ),
    );
  }

  var diferenca = getDatas('checkOut').difference(getDatas('checkIn')).inDays;
  for (var i = 0; i < diferenca; i++) {
    DateTime data = getDatas('checkIn').add(Duration(days: i));
    if (!getDatas('checkIn').add(Duration(days: i)).isAfter(DateTime.now())) {
      despesasLog.add(
        Despesa(
          id: (Random().nextInt(9999)).toString(),
          title: 'Diária',
          amount: getDiaria(),
          date: DateTime(data.year, data.month, data.day, 0, 0, 0),
        ),
      );
    }
  }
  despesasLog.sort((a, b) {
    return -a.date.compareTo(b.date);
  });
}

List<Despesa> despesasLog = [];

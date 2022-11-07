import 'data/seguranca_data.dart';
import '../globals.dart' as globals;

class Seguranca {
  final String id;
  final String title;
  final String info;
  final String date;
  final String tag;

  const Seguranca({
    required this.id,
    required this.title,
    required this.info,
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

void getLog() {
  // var logList = [];
  // logList = globals.loginData['hospede']['reservas'][getIndex()]['reserva']
  //     ['quarto']['registros'];
  var logs = [];
  logs = globals.loginData['hospede']['reservas'][getIndex()]['reserva']
      ['quarto']['registros'];

  //print(log);

  for (var i = 0; i < logs.length; i++) {
    var logMap = logs[i] as Map;
    SEGURANCA_DATA.add(
      Seguranca(
        id: logMap['_id'],
        title: 'Acesso ao quarto',
        info: logMap.containsKey('reserva') ? 'Hóspede' : 'Funcionário',
        date: logMap['createdAt'],
        tag: 'tag',
      ),
    );
  }

  SEGURANCA_DATA.sort((a, b) {
    return -DateTime.parse(a.date).compareTo(DateTime.parse(b.date));
  });
}

void addLog(Map<dynamic, dynamic> res) {
  if (res.containsKey('reserva')) {
    var newData = Seguranca(
      id: 's1',
      title: 'Acesso ao quarto',
      info: 'Hóspede',
      //date: DateTime.now().toIso8601String(),
      date: res['createdAt'],
      tag: 'tag',
    );
    SEGURANCA_DATA.insert(0, newData);
  }
  if (res.containsKey('funcionario')) {
    var newData = Seguranca(
      id: 's1',
      title: 'Acesso ao quarto',
      info: 'Funcionário',
      //date: DateTime.now().toIso8601String(),
      date: res['createdAt'],
      tag: 'tag',
    );
    SEGURANCA_DATA.insert(0, newData);
  }
  if (res.containsKey('status')) {
    var newData = Seguranca(
      id: res['_id'].toString(),
      title: res['status'].toString().toLowerCase().contains('entrou')
          ? 'Entrada de veículo'
          : 'Saída de veículo',
      info: 'placa',
      //date: DateTime.now().toIso8601String(),
      date: res['createdAt'],
      tag: 'car',
    );
    SEGURANCA_DATA.insert(0, newData);
  }
}

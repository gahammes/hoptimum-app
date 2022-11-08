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
  var logs = [];
  var registros = [];
  var listCarros = [];
  listCarros = globals.loginData['hospede']['carros'];
  logs = globals.loginData['hospede']['reservas'][getIndex()]['reserva']
      ['quarto']['registros'];

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

  if (listCarros.isNotEmpty) {
    for (var i = 0; i < listCarros.length; i++) {
      var listRegistros = [];
      var placa = listCarros[i]['placa'].toString();
      var index = i;
      listRegistros = globals.loginData['hospede']['carros'][i]['registros'];
      if (listRegistros.isNotEmpty) {
        registros = globals.loginData['hospede']['carros'][index]['registros'];
        for (var i = 0; i < registros.length; i++) {
          var registroMap = registros[i] as Map;
          SEGURANCA_DATA.add(
            Seguranca(
              id: registroMap['_id'].toString(),
              title: registroMap['status']
                      .toString()
                      .toLowerCase()
                      .contains('entrou')
                  ? 'Entrada de veículo'
                  : 'Saída de veículo',
              info: 'Placa: $placa',
              date: registroMap['createdAt'],
              tag: 'car',
            ),
          );
        }
      }
    }
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
      info: globals.loginData['hospede']['carros'][0]['placa'],
      //date: DateTime.now().toIso8601String(),
      date: res['createdAt'],
      tag: 'car',
    );
    SEGURANCA_DATA.insert(0, newData);
  }
}

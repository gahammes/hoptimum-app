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

List<Seguranca> segurancaLog = [];

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
    segurancaLog.add(
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
          segurancaLog.add(
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
  segurancaLog.sort((a, b) {
    return -DateTime.parse(a.date).compareTo(DateTime.parse(b.date));
  });
}

void getLogFunc() {
  var logs = [];
  var registros = [];
  var listCarros = [];
  listCarros = globals.loginData['funcionario']['carros'];
  logs = globals.loginData['funcionario']['registros'];

  for (var i = 0; i < logs.length; i++) {
    var logMap = logs[i] as Map;
    segurancaLog.add(
      Seguranca(
        id: logMap['_id'].toString(),
        title: 'Acesso ao quarto',
        info: logMap['quarto']['numero'].toString(),
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
      listRegistros =
          globals.loginData['funcionario']['carros'][i]['registros'];
      if (listRegistros.isNotEmpty) {
        registros =
            globals.loginData['funcionario']['carros'][index]['registros'];
        for (var i = 0; i < registros.length; i++) {
          var registroMap = registros[i] as Map;
          segurancaLog.add(
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
  segurancaLog.sort((a, b) {
    return -DateTime.parse(a.date).compareTo(DateTime.parse(b.date));
  });
}

void addLog(Map<dynamic, dynamic> res) {
  var loginData = globals.loginData as Map;
  Seguranca newData = Seguranca(
    id: '',
    title: '',
    info: '',
    date: DateTime.now().toIso8601String(),
    tag: '',
  );
  if (loginData.containsKey('hospede')) {
    if (res.containsKey('reserva')) {
      newData = Seguranca(
        id: res['_id'].toString(),
        title: 'Acesso ao quarto',
        info: 'Hóspede',
        date: res['createdAt'],
        tag: 'tag',
      );
    }
    if (res.containsKey('funcionario')) {
      newData = Seguranca(
        id: res['_id'].toString(),
        title: 'Acesso ao quarto',
        info: 'Funcionário',
        date: res['createdAt'],
        tag: 'tag',
      );
      //SEGURANCA_DATA.insert(0, newData);
    }
    if (res.containsKey('status')) {
      newData = Seguranca(
        id: res['_id'].toString(),
        title: res['status'].toString().toLowerCase().contains('entrou')
            ? 'Entrada de veículo'
            : 'Saída de veículo',
        info: res['carro']['placa'].toString(),
        date: res['createdAt'],
        tag: 'car',
      );
      //SEGURANCA_DATA.insert(0, newData);
    }
  }

  if (loginData.containsKey('funcionario')) {
    if (res.containsKey('status')) {
      newData = Seguranca(
        id: res['_id'].toString(),
        title: res['status'].toString().toLowerCase().contains('entrou')
            ? 'Entrada de veículo'
            : 'Saída de veículo',
        info: res['carro']['placa'].toString(),
        date: res['createdAt'],
        tag: 'car',
      );
      //SEGURANCA_DATA.insert(0, newData);
    } else {
      newData = Seguranca(
        id: res['_id'].toString(),
        title: 'Acesso ao quarto',
        info: res['quarto']['numero'],
        date: res['createdAt'],
        tag: 'tag',
      );
      //SEGURANCA_DATA.insert(0, newData);
    }
  }
  segurancaLog.insert(0, newData);
  if (globals.listKey.currentState == null) {
  } else {
    globals.listKey.currentState!.insertItem(
      0,
      duration: const Duration(milliseconds: 350),
    );
  }
}

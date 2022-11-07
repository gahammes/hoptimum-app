import 'data/seguranca_data.dart';

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

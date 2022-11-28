import '../globals.dart' as globals;

enum Status {
  espera,
  recebido,
  preparando,
  finalizado,
}

Status getStatus(String status) {
  switch (status) {
    case 'espera':
      return Status.espera;
    case 'recebido':
      return Status.recebido;
    case 'preparando':
      return Status.preparando;
    case 'finalizado':
      return Status.finalizado;
    default:
      return Status.finalizado;
  }
}

class Servico {
  final String id;
  final String title;
  final String numQuarto;
  final DateTime data;
  Status status;

  Servico({
    required this.id,
    required this.title,
    required this.numQuarto,
    required this.data,
    required this.status,
  });
}

List<Servico> servicosList = [];

void getServicos() {
  var servicos = [];
  servicos = globals.loginData['funcionario']['servicos'];
  for (var i = 0; i < servicos.length; i++) {
    var servicoMap = servicos[i] as Map;
    if (servicoMap['status'] != 'finalizado') {
      servicosList.add(
        Servico(
          id: servicoMap['_id'].toString(),
          title: servicoMap['servico']['nome'].toString(),
          numQuarto: servicoMap['reserva']['quarto']['numero'].toString(),
          data: DateTime.parse(servicoMap['createdAt'].toString())
              .subtract(const Duration(hours: 3)),
          status: getStatus(servicoMap['status']),
        ),
      );
    } else {
      servicosFinalizadosList.add(
        Servico(
          id: servicoMap['_id'].toString(),
          title: servicoMap['servico']['nome'].toString(),
          numQuarto: servicoMap['reserva']['quarto']['numero'].toString(),
          data: DateTime.parse(servicoMap['createdAt'].toString())
              .subtract(const Duration(hours: 3)),
          status: Status.finalizado,
        ),
      );
    }
  }
}

List<Servico> servicosFinalizadosList = [];

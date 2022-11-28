import '../globals.dart' as globals;

enum Status {
  espera,
  recebido,
  preparando,
  caminho,
  entregue,
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
    case 'caminho':
      return Status.caminho;
    case 'entregue':
      return Status.entregue;
    case 'finalizado':
      return Status.finalizado;
    default:
      return Status.finalizado;
  }
}

class Pedido {
  final String id;
  final String refeicao;
  final String numQuarto;
  final double total;
  final DateTime data;
  Status status;

  Pedido({
    required this.id,
    required this.refeicao,
    required this.numQuarto,
    required this.total,
    required this.data,
    required this.status,
  });
}

List<Pedido> pedidosList = [
  //PEDIDOS
  // Pedido(
  //   id: 98256,
  //   refeicao: [
  //     'Pizza de quatro quejos',
  //   ],
  //   numQuarto: 109,
  //   total: 15.0,
  //   data: DateTime(2022, 6, 15, 21, 03),
  //   status: Status.espera,
  // ),
];

void getPedidos() {
  var pedidos = [];
  pedidos = globals.loginData['funcionario']['servicos'];
  for (var i = 0; i < pedidos.length; i++) {
    var pedidoMap = pedidos[i] as Map;
    if (pedidoMap['status'] != 'finalizado') {
      pedidosList.add(
        Pedido(
          id: pedidoMap['_id'].toString(),
          refeicao: pedidoMap['servico']['nome'].toString(),
          numQuarto: pedidoMap['reserva']['quarto']['numero'].toString(),
          total: double.parse(pedidoMap['servico']['preco'].toString()),
          data: DateTime.parse(pedidoMap['createdAt'].toString())
              .subtract(const Duration(hours: 3)),
          status: getStatus(pedidoMap['status']),
        ),
      );
    } else {
      pedidosFinalizadosList.add(
        Pedido(
          id: pedidoMap['_id'].toString(),
          refeicao: pedidoMap['servico']['nome'].toString(),
          numQuarto: pedidoMap['reserva']['quarto']['numero'].toString(),
          total: double.parse(pedidoMap['servico']['preco'].toString()),
          data: DateTime.parse(pedidoMap['createdAt'].toString())
              .subtract(const Duration(hours: 3)),
          status: Status.finalizado,
        ),
      );
    }
  }
}

List<Pedido> pedidosFinalizadosList = [
  //PEDIDOS_FINALIZADOS
  // Pedido(
  //   id: '27310',
  //   refeicao: 'Spaghetti com Molho de Tomate',
  //   numQuarto: 226.toString(),
  //   total: 15.0,
  //   data: DateTime(2022, 6, 14, 21, 10),
  //   status: Status.finalizado,
  // ),
];

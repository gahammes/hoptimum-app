import '../globals.dart' as globals;

enum Status {
  espera,
  recebido,
  preparando,
  caminho,
  entregue,
  finalizado,
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
  // Pedido(
  //   id: 53729,
  //   refeicao: ['Carne assada com vegetais'],
  //   numQuarto: 226,
  //   total: 15.0,
  //   data: DateTime(2022, 6, 15, 13, 47),
  //   status: Status.espera,
  // ),
  // Pedido(
  //   id: 36523,
  //   refeicao: ['Salada com Salmão Defumado'],
  //   numQuarto: 101,
  //   total: 15.0,
  //   data: DateTime(2022, 6, 15, 12, 36),
  //   status: Status.espera,
  // ),
  // Pedido(
  //   id: 31517,
  //   refeicao: ['Panqueca Americana'],
  //   numQuarto: 319,
  //   total: 15.0,
  //   data: DateTime(2022, 6, 15, 9, 54),
  //   status: Status.espera,
  // ),
  // Pedido(
  //   id: 18240,
  //   refeicao: ['Iogurte com cereais e frutas'],
  //   numQuarto: 109,
  //   total: 15.0,
  //   data: DateTime(2022, 6, 15, 7, 14),
  //   status: Status.espera,
  // ),
];

void getPedidos() {
  var pedidos = [];
  pedidos = globals.loginData['funcionario']['servicos'];
  for (var i = 0; i < pedidos.length; i++) {
    var pedidoMap = pedidos[i] as Map;
    pedidosList.add(
      Pedido(
        id: pedidoMap['_id'].toString(),
        refeicao: pedidoMap['servico']['nome'].toString(),
        numQuarto: pedidoMap['reserva']['quarto']['numero'].toString(),
        total: double.parse(pedidoMap['servico']['preco'].toString()),
        data: DateTime.parse(pedidoMap['createdAt'].toString())
            .subtract(const Duration(hours: 3)),
        status: Status.espera,
      ),
    );
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
  // Pedido(
  //   id: 83522,
  //   refeicao: ['Fusilli com tomates'],
  //   numQuarto: 101,
  //   total: 15.0,
  //   data: DateTime(2022, 6, 14, 12, 45),
  //   status: Status.finalizado,
  // ),
  // Pedido(
  //   id: 74417,
  //   refeicao: ['Croissant de chocolate'],
  //   numQuarto: 319,
  //   total: 15.0,
  //   data: DateTime(2022, 6, 14, 10, 02),
  //   status: Status.finalizado,
  // ),
  // Pedido(
  //   id: 86173,
  //   refeicao: ['Panqueca Americana'],
  //   numQuarto: 109,
  //   total: 15.0,
  //   data: DateTime(2022, 6, 14, 8, 23),
  //   status: Status.finalizado,
  // ),
];

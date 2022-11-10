enum Status {
  espera,
  recebido,
  preparando,
  finalizado,
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

var servicosList = [
  //SERVICOS
  Servico(
    id: '123',
    title: 'Serviço de quarto',
    numQuarto: '25a',
    data: DateTime(2022, 6, 14, 10, 10),
    status: Status.espera,
  )
];

var servicosFinalizadosList = [
  //SERVICOS_FINALIZADOS
  Servico(
    id: '321',
    title: 'Serviço de quarto',
    numQuarto: '25a',
    data: DateTime(2022, 6, 13, 15, 10),
    status: Status.finalizado,
  )
];

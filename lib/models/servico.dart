enum Status {
  Espera,
  Recebido,
  Preparando,
  Finalizado,
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

var SERVICOS = [
  Servico(
    id: '123',
    title: 'Serviço de quarto',
    numQuarto: '25a',
    data: DateTime(2022, 6, 14, 10, 10),
    status: Status.Espera,
  )
];

var SERVICOS_FINALIZADOS = [
  Servico(
    id: '321',
    title: 'Serviço de quarto',
    numQuarto: '25a',
    data: DateTime(2022, 6, 13, 15, 10),
    status: Status.Finalizado,
  )
];

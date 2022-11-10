class Report {
  final String nome;
  final String tag;
  final int numQuart;
  final String detalhes;
  final DateTime hora;

  Report({
    required this.nome,
    required this.tag,
    required this.numQuart,
    required this.detalhes,
    required this.hora,
  });
}

var reportesList = [
  //REPORTES
  Report(
    nome: 'Felipe Vergueiro Salvado',
    tag: 'cartao',
    numQuart: 109,
    detalhes: 'Perdi meu cartao chave e ele foi usado para fazer pedidos',
    hora: DateTime(2022, 6, 15, 21, 08),
  ),
  Report(
    nome: 'Bruna Maciel',
    tag: 'cartao',
    numQuart: 319,
    detalhes:
        'Minha carteira foi roubada e alguém usou o cartão para entrar no meu quarto',
    hora: DateTime(2022, 6, 15, 17, 45),
  ),
  Report(
    nome: 'Eveline Álvares',
    tag: 'carro',
    numQuart: 226,
    detalhes: 'O histórico mostra meu carro saindo do hotel mas nao foi eu',
    hora: DateTime(2022, 6, 15, 13, 22),
  ),
  Report(
    nome: 'Kenny Barreiros Monjardim',
    tag: 'cartao',
    numQuart: 101,
    detalhes: 'Perdi meu cartão, poderia bloqueá-lo?',
    hora: DateTime(2022, 6, 15, 10, 31),
  ),
];

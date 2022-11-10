class Notificacao {
  final String id;
  final String title;
  final String cod;
  final String date;
  final String tag;

  const Notificacao({
    required this.id,
    required this.title,
    required this.cod,
    required this.date,
    required this.tag,
  });
}

const notificacaoData = [
  Notificacao(
    id: 's3',
    title: 'Pedido entregue',
    cod: '98256',
    date: 'quarta-feira, 15 de junho 21:03',
    tag: 'ref',
  ),
  Notificacao(
    id: 's3',
    title: 'Pedido à caminho',
    cod: '98256',
    date: 'quarta-feira, 15 de junho 20:59',
    tag: 'ref',
  ),
  Notificacao(
    id: 's4',
    title: 'Pedido em preparação',
    cod: '98256',
    date: 'quarta-feira, 15 de junho 20:21',
    tag: 'ref',
  ),
  Notificacao(
    id: 's5',
    title: 'Pedido recebido',
    cod: '98256',
    date: 'quarta-feira, 15 de junho 20:12',
    tag: 'ref',
  ),
  Notificacao(
    id: 's1',
    title: 'Serviço completo',
    cod: '11604',
    date: 'terça-feira, 14 de junho 16:08',
    tag: 'serv',
  ),
  Notificacao(
    id: 's6',
    title: 'Serviço solicitado',
    cod: '11604',
    date: 'terça-feira, 14 de junho 15:25',
    tag: 'serv',
  ),
];

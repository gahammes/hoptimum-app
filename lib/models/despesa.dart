class Despesa {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  const Despesa(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}

var despesasLog = [
  //DESPESAS_DATA
  Despesa(
    id: 'd67',
    title: 'Pedido',
    amount: 79.90,
    date: DateTime(2022, 6, 15, 21, 03),
  ),
  Despesa(
    id: 'd1',
    title: 'Diária',
    amount: 100.00,
    date: DateTime(2022, 6, 15, 0, 0),
  ),
  Despesa(
    id: 'd4',
    title: 'Diária',
    amount: 100.00,
    date: DateTime(2022, 6, 14, 0, 0),
  ),
  Despesa(
    id: 'd2',
    title: 'Bar',
    amount: 46.59,
    date: DateTime(2022, 6, 13, 23, 52),
  ),
  Despesa(
    id: 'd6',
    title: 'Diária',
    amount: 100.00,
    date: DateTime(2022, 6, 13, 0, 0),
  ),
  Despesa(
    id: 'd3',
    title: 'Restaurante',
    amount: 89.99,
    date: DateTime(2022, 6, 12, 13, 22),
  ),
  Despesa(
    id: 'd7',
    title: 'Diária',
    amount: 100.00,
    date: DateTime(2022, 6, 12, 0, 0),
  ),
  Despesa(
    id: 'd7',
    title: 'Restaurante',
    amount: 40.79,
    date: DateTime(2022, 6, 11, 9, 20),
  ),
];

class Hotel {
  final String nome;
  final String local;
  final String telefone;
  final String email;
  final List<String> horariosRef;
  final List<String> horariosLaz;
  final List<String> horariosServ;

  const Hotel({
    required this.nome,
    required this.local,
    required this.telefone,
    required this.email,
    required this.horariosRef,
    required this.horariosLaz,
    required this.horariosServ,
  });
}

const hotelDados = [
  //HOTEL_DATA
  Hotel(
    nome: 'Nome do hotel',
    local: 'Curitiba, PR',
    telefone: '41########',
    email: 'email@hotel.com',
    horariosRef: [
      'Café da manha: 6:00 às 10:00',
      'Almoço: 11:00 às 14:00',
      'Jantar: 19:00 às 22:00',
    ],
    horariosLaz: [
      'Piscinas: 8:00 às 18:00',
      'Academia: 6:00 às 17:00',
      'Bar: 21:00 às 01:00',
    ],
    horariosServ: [
      'Serviço de quarto: 7:00 às 10:30',
      'Solicitaçao de limpeza: 14:00 às 18:00',
    ],
  )
];

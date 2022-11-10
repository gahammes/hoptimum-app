class Hospede {
  final String cpf;
  final String nome;
  final String telefone;
  final List<Dependente> dependentes;
  final int numCartaoChave;
  final String email;
  final DateTime nascimento;
  final Carro carro;
  final Reserva reserva;

  const Hospede({
    required this.cpf,
    required this.nome,
    required this.telefone,
    required this.dependentes,
    required this.numCartaoChave,
    required this.email,
    required this.nascimento,
    required this.carro,
    required this.reserva,
  });
}

class Dependente {
  final String nome;
  final String idade;
  //TODO:telefone
  final bool cartaoChave;
  final int documento;

  const Dependente({
    required this.nome,
    required this.idade,
    required this.cartaoChave,
    required this.documento,
  });
}

class Carro {
  final String dono;
  final String placa;
  final String modelo;
  final String cor;

  const Carro({
    required this.dono,
    required this.placa,
    required this.modelo,
    required this.cor,
  });
}

class Reserva {
  final int numReserva;
  final int quarto;
  final DateTime dataReserva;
  final DateTime dataCheckIn;
  final DateTime dataCheckOut;
  final List<int> numCartaoChave;

  const Reserva({
    required this.numReserva,
    required this.quarto,
    required this.dataReserva,
    required this.dataCheckIn,
    required this.dataCheckOut,
    required this.numCartaoChave,
  });
}

var hospedeList = [
  //HOSPEDES
  Hospede(
    cpf: '050.841.280-32',
    nome: 'Felipe Vergueiro Salvado',
    telefone: '(45) 99325-6621',
    dependentes: [
      const Dependente(
        nome: 'Cloe Vergueiro Salvado',
        idade: 'Adulto',
        cartaoChave: true,
        documento: 11111111112,
      ),
      const Dependente(
        nome: 'Alana Vergueiro Salvado',
        idade: 'Criança',
        cartaoChave: false,
        documento: 11111111113,
      ),
      const Dependente(
        nome: 'Abel Vergueiro Salvado',
        idade: 'Criança',
        cartaoChave: false,
        documento: 11111111114,
      ),
    ],
    numCartaoChave: 2,
    email: 'fvsalvado@email.com',
    nascimento: DateTime(1981, 6, 22),
    carro: const Carro(
      dono: 'Felipe Vergueiro Salvado',
      placa: 'AAA1A11',
      modelo: 'modelo',
      cor: 'Preto',
    ),
    reserva: Reserva(
      numReserva: 11111111111,
      quarto: 101,
      dataReserva: DateTime(2022, 5, 15),
      dataCheckIn: DateTime(2022, 6, 11),
      dataCheckOut: DateTime(2022, 5, 17),
      numCartaoChave: [1011, 1012],
    ),
  ),
  Hospede(
    cpf: '927.017.050-02',
    nome: 'Bruna Maciel',
    telefone: '(48) 98245-4614',
    dependentes: [
      const Dependente(
        nome: 'Esther Maciel',
        idade: 'Criança',
        cartaoChave: false,
        documento: 22222222223,
      ),
    ],
    numCartaoChave: 1,
    email: 'bmaciel@email.com',
    nascimento: DateTime(1993, 11, 19),
    carro: const Carro(
      dono: 'Bruna Maciel',
      placa: 'BBB2B22',
      modelo: 'modelo',
      cor: 'Branco',
    ),
    reserva: Reserva(
      numReserva: 22222222222,
      quarto: 319,
      dataReserva: DateTime(2022, 5, 15),
      dataCheckIn: DateTime(2022, 6, 11),
      dataCheckOut: DateTime(2022, 5, 17),
      numCartaoChave: [3191],
    ),
  ),
  Hospede(
    cpf: '309.693.570-01',
    nome: 'Eveline Álvares',
    telefone: '(51) 97298-8942',
    dependentes: [
      const Dependente(
        nome: 'Milan Álvares',
        idade: 'Criança',
        cartaoChave: false,
        documento: 33333333334,
      ),
      const Dependente(
        nome: 'Magda Álvares',
        idade: 'Criança',
        cartaoChave: false,
        documento: 33333333335,
      ),
      const Dependente(
        nome: 'Augusto Álvares',
        idade: 'Adulto',
        cartaoChave: true,
        documento: 33333333336,
      ),
    ],
    numCartaoChave: 2,
    email: 'ealvares@email.com',
    nascimento: DateTime(1988, 2, 3),
    carro: const Carro(
      dono: 'Eveline Álvares',
      placa: 'CCC3C33',
      modelo: 'modelo',
      cor: 'Cinza',
    ),
    reserva: Reserva(
      numReserva: 5492471102,
      quarto: 226,
      dataReserva: DateTime(2022, 5, 15),
      dataCheckIn: DateTime(2022, 6, 11),
      dataCheckOut: DateTime(2022, 6, 19),
      numCartaoChave: [2261, 2262],
    ),
  ),
  Hospede(
    cpf: '973.415.310-29',
    nome: 'Kenny Barreiros Monjardim',
    telefone: '(61) 98495-6742',
    dependentes: [
      const Dependente(
        nome: 'Aryan Barreiros Monjardim',
        idade: 'Adulto',
        cartaoChave: true,
        documento: 44444444445,
      ),
      const Dependente(
        nome: 'Finn Barreiros Monjardim',
        idade: 'Adulto',
        cartaoChave: false,
        documento: 44444444446,
      ),
    ],
    numCartaoChave: 2,
    email: 'kbmonjardim@email.com',
    nascimento: DateTime(1996, 1, 14),
    carro: const Carro(
      dono: 'Kenny Barreiros Monjardim',
      placa: 'DDD4D44',
      modelo: 'modelo',
      cor: 'Preto',
    ),
    reserva: Reserva(
      numReserva: 44444444444,
      quarto: 109,
      dataReserva: DateTime(2022, 5, 15),
      dataCheckIn: DateTime(2022, 6, 11),
      dataCheckOut: DateTime(2022, 5, 17),
      numCartaoChave: [1091, 1092],
    ),
  ),
  Hospede(
    cpf: '352.813.740-10',
    nome: 'Gabriela Sodré',
    telefone: '(79) 99578-7841',
    dependentes: [
      const Dependente(
        nome: 'Alba Sodré',
        idade: 'Adulto',
        cartaoChave: true,
        documento: 5555555556,
      ),
      const Dependente(
        nome: 'Lázaro Sodré',
        idade: 'Adulto',
        cartaoChave: true,
        documento: 5555555557,
      ),
    ],
    numCartaoChave: 3,
    email: 'gsodre@email.com',
    nascimento: DateTime(1996, 1, 14),
    carro: const Carro(
      dono: 'Gabriela Sodré',
      placa: 'EEE5E55',
      modelo: 'modelo',
      cor: 'Preto',
    ),
    reserva: Reserva(
      numReserva: 55555555555,
      quarto: 314,
      dataReserva: DateTime(2022, 5, 15),
      dataCheckIn: DateTime(2022, 6, 11),
      dataCheckOut: DateTime(2022, 5, 17),
      numCartaoChave: [3141, 3142, 3143],
    ),
  ),
  Hospede(
    cpf: '636.588.390-07',
    nome: 'Ian Bicalho',
    telefone: '(68) 97547-3536',
    dependentes: [
      const Dependente(
        nome: 'Crystal Bicalho',
        idade: 'Criança',
        cartaoChave: false,
        documento: 66666666667,
      ),
      const Dependente(
        nome: 'Gabriel Bicalho',
        idade: 'Criança',
        cartaoChave: false,
        documento: 66666666668,
      ),
    ],
    numCartaoChave: 1,
    email: 'ibicalho@email.com',
    nascimento: DateTime(1996, 1, 14),
    carro: const Carro(
      dono: 'Ian Bicalho',
      placa: 'FFF66F66',
      modelo: 'modelo',
      cor: 'Preto',
    ),
    reserva: Reserva(
      numReserva: 66666666666,
      quarto: 545,
      dataReserva: DateTime(2022, 5, 15),
      dataCheckIn: DateTime(2022, 6, 11),
      dataCheckOut: DateTime(2022, 5, 17),
      numCartaoChave: [5451],
    ),
  ),
  Hospede(
    cpf: '190.228.180-20',
    nome: 'Sophia Baldaia',
    telefone: '(12) 98678-6064',
    dependentes: [],
    numCartaoChave: 1,
    email: 'sbaldaia@email.com',
    nascimento: DateTime(1996, 1, 14),
    carro: const Carro(
      dono: 'Sophia Baldaia',
      placa: 'GGG7G77',
      modelo: 'modelo',
      cor: 'Preto',
    ),
    reserva: Reserva(
      numReserva: 77777777777,
      quarto: 404,
      dataReserva: DateTime(2022, 5, 15),
      dataCheckIn: DateTime(2022, 6, 11),
      dataCheckOut: DateTime(2022, 5, 17),
      numCartaoChave: [4041],
    ),
  ),
];

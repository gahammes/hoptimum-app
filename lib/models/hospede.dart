import '../globals.dart' as globals;

class Hospede {
  final String cpf;
  final String nome;
  final String telefone;
  final List<Dependente> dependentes;
  final String email;
  final DateTime nascimento;
  final List<Carro> carro;
  final Reserva reserva;

  const Hospede({
    required this.cpf,
    required this.nome,
    required this.telefone,
    required this.dependentes,
    required this.email,
    required this.nascimento,
    required this.carro,
    required this.reserva,
  });
}

class Dependente {
  final String cpf;
  final String nome;
  final String telefone;
  final String email;
  final DateTime nascimento;

  const Dependente({
    required this.cpf,
    required this.nome,
    required this.telefone,
    required this.email,
    required this.nascimento,
  });
}

class Carro {
  final String placa;
  final String modelo;
  final String cor;

  const Carro({
    required this.placa,
    required this.modelo,
    required this.cor,
  });
}

class Reserva {
  final String id;
  final String quarto;
  final DateTime dataReserva;
  final DateTime dataCheckIn;
  final DateTime dataCheckOut;
  final List<String> cartoes;

  const Reserva({
    required this.id,
    required this.quarto,
    required this.dataReserva,
    required this.dataCheckIn,
    required this.dataCheckOut,
    required this.cartoes,
  });
}

int getTitular(int index) {
  List list = globals.hospedesList[index]['hospedes'];
  for (var i = 0; i < list.length; i++) {
    var hosp = globals.hospedesList[index]['hospedes'][i] as Map;
    if (hosp['titular']) {
      return i;
    }
  }
  return -1;
}

void getHospList() {
  List<Dependente> dependentes = [];
  List<Carro> carros = [];
  List<String> cartoes = [];
  var cpf = '';
  var nome = '';
  var telefone = '';
  var email = '';
  var nascimento = DateTime.now();
  for (var i = 0; i < globals.hospedesList.length; i++) {
    var reservaMap = globals.hospedesList[i] as Map;
    List hospedes = globals.hospedesList[i]['hospedes'];
    for (var j = 0; j < hospedes.length; j++) {
      var map = globals.hospedesList[i]['hospedes'][j]['hospede'] as Map;
      if (getTitular(i) == j) {
        nome = map['nome'];
        cpf = map['cpf'];
        telefone = map['telefone'];
        email = map['email'];
        nascimento = DateTime.parse(map['nascimento'].toString());
        List carrosList =
            globals.hospedesList[i]['hospedes'][j]['hospede']['carros'];
        for (var w = 0; w < carrosList.length; w++) {
          carros.add(Carro(
            placa: map['carros'][w]['placa'],
            modelo: map['carros'][w]['modelo'],
            cor: map['carros'][w]['cor'],
          ));
        }
      } else {
        //TODO:PAREI AQUI!!!!
        dependentes.add(Dependente(
          cpf: map['cpf'],
          nome: map['nome'],
          telefone: map['telefone'],
          email: map['email'],
          nascimento: DateTime.parse(map['nascimento'].toString()),
        ));
      }
    }
    List cartaoList = globals.hospedesList[i]['cartoesChave'];
    for (var y = 0; y < cartaoList.length; y++) {
      var cartaoMap = globals.hospedesList[i]['cartoesChave'][y] as Map;
      cartoes.add(cartaoMap['codigo']);
    }
    hospedeList.add(Hospede(
      cpf: cpf,
      nome: nome,
      telefone: telefone,
      dependentes: dependentes,
      email: email,
      nascimento: nascimento,
      carro: carros,
      reserva: Reserva(
        id: reservaMap['_id'],
        quarto: reservaMap['quarto']['numero'],
        dataReserva: DateTime.parse(reservaMap['createdAt'].toString()),
        dataCheckIn: DateTime.parse(reservaMap['checkIn'].toString()),
        dataCheckOut: DateTime.parse(reservaMap['checkOut'].toString()),
        cartoes: cartoes,
      ),
    ));
    dependentes = [];
    carros = [];
    cartoes = [];
    cpf = '';
    nome = '';
    telefone = '';
    email = '';
    nascimento = DateTime.now();
  }
}

List<Hospede> hospedeList = [];

import '../globals.dart' as globals;

class Report {
  final String nome;
  final String numQuart;
  final String detalhes;
  final DateTime hora;

  Report({
    required this.nome,
    required this.numQuart,
    required this.detalhes,
    required this.hora,
  });
}

int getIndex(List reservas) {
  int index = reservas.indexWhere((reserva) {
    Map mapa = reserva as Map;
    if (mapa['reserva']['status'].toString().toLowerCase() == 'ativa') {
      return true;
    } else {
      return false;
    }
  });
  return index;
}

void getReportes() {
  List reportes = globals.loginData['funcionario']['relatos'];
  for (var i = 0; i < reportes.length; i++) {
    var reporte = reportes[i] as Map;
    int index = getIndex(reporte['hospede']['reservas']);
    reportesList.add(
      Report(
        nome: reporte['hospede']['nome'],
        numQuart: reporte['hospede']['reservas'][index]['reserva']['quarto']
            ['numero'],
        detalhes: reporte['texto'],
        hora: DateTime.parse(reporte['createdAt']),
      ),
    );
  }
  reportesList.sort((a, b) {
    return -a.hora.compareTo(b.hora);
  });
}

void addReporte(Map<dynamic, dynamic> res) {
  int index = getIndex(res['hospede']['reservas']);
  reportesList.insert(
    0,
    Report(
      nome: res['hospede']['nome'],
      numQuart: res['hospede']['reservas'][index]['reserva']['quarto']
          ['numero'],
      detalhes: res['texto'],
      hora: DateTime.parse(res['createdAt']),
    ),
  );
}

List<Report> reportesList = [];

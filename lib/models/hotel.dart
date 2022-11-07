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

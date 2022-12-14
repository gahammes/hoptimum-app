class Quarto {
  final int id;
  final String nome;
  final String tipo;
  final double preco;
  final String rating;
  final String url;
  Quarto({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.preco,
    required this.url,
    required this.rating,
  });
}

var quartosList = [
  //QUARTOS
  Quarto(
    id: 100,
    nome: 'Single Room',
    tipo: 'Quarto solteiro',
    preco: 80.0,
    rating: '4.8',
    url:
        'https://cdn.pixabay.com/photo/2016/04/15/11/43/hotel-1330834_960_720.jpg',
  ),
  Quarto(
    id: 100,
    nome: 'Double Room',
    tipo: 'Quarto casal',
    preco: 100.0,
    rating: '4.8',
    url:
        'https://cdn.pixabay.com/photo/2016/09/18/03/28/travel-1677347_960_720.jpg',
  ),
  Quarto(
    id: 100,
    nome: 'Family Room',
    tipo: 'Quarto família',
    preco: 120.0,
    rating: '4.6',
    url:
        'https://cdn.pixabay.com/photo/2017/01/14/12/48/hotel-1979406_960_720.jpg',
  ),
];

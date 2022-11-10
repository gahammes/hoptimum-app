enum Preco { razoavel, barato, caro }

class Refeicao {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final int duration;
  final double price;
  final Preco affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Refeicao({
    required this.id,
    required this.title,
    required this.categories,
    required this.imageUrl,
    required this.duration,
    required this.price,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });
}

const refeitcoesList = [
  //DUMMY_MEALS
  Refeicao(
    id: 's1',
    title: 'Serviço de quarto',
    categories: ['s1'],
    imageUrl:
        'https://cdn.sanity.io/images/tbvc1g2x/production/e48f7be484d6838b1812cbebcbbcf068b8581bfc-1600x1067.jpg?w=1600&h=1067&auto=format',
    duration: 50,
    affordability: Preco.barato,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Refeicao(
    id: 'm13',
    title: 'Iogurte com cereais e frutas',
    categories: ['c100'],
    imageUrl:
        'https://images.unsplash.com/photo-1581559178851-b99664da71ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
    duration: 20,
    affordability: Preco.barato,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Refeicao(
    id: 'm11',
    title: 'Torrada e ovo frito',
    categories: ['c100'],
    imageUrl:
        'https://images.unsplash.com/photo-1525351484163-7529414344d8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
    duration: 25,
    affordability: Preco.barato,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Refeicao(
    id: 'm14',
    title: 'Carne assada com vegetais',
    categories: ['c200'],
    imageUrl:
        'https://images.unsplash.com/photo-1573225342350-16731dd9bf3d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=762&q=80',
    duration: 60,
    affordability: Preco.razoavel,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Refeicao(
    id: 'm18',
    title: 'Pizza de quatro quejos',
    categories: ['c300'],
    imageUrl:
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    duration: 60,
    affordability: Preco.barato,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Refeicao(
    id: 'm1',
    categories: [
      'c200',
    ],
    title: 'Spaghetti com Molho de Tomate',
    affordability: Preco.barato,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
    duration: 40,
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    price: 15.00,
  ),
  Refeicao(
    id: 'm3',
    categories: [
      'c300',
    ],
    title: 'Hamburguer clássico',
    affordability: Preco.razoavel,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    duration: 45,
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    price: 15.00,
  ),
  Refeicao(
    id: 'm6',
    categories: [
      'c200',
    ],
    title: 'Mousse de Laranja',
    affordability: Preco.barato,
    imageUrl:
        'https://cdn.pixabay.com/photo/2017/05/01/05/18/pastry-2274750_1280.jpg',
    duration: 40,
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    price: 15.00,
  ),
  Refeicao(
    id: 'm9',
    categories: [
      'c300',
    ],
    title: 'Suflê de Chocolate',
    affordability: Preco.barato,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/08/07/21/07/souffle-412785_1280.jpg',
    duration: 30,
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    price: 15.00,
  ),
];

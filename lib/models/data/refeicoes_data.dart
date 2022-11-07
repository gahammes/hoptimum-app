import 'package:flutter/material.dart';

import '../category.dart';
import '../meal.dart';
import '../solicitacao.dart';

const SOLICITACAO = [
  Solicitacao(
    id: 'c01',
    title: 'Refeições',
    tipo: 'ref',
  ),
  Solicitacao(
    id: 'c02',
    title: 'Serviços',
    tipo: 'serv',
  ),
];

const DUMMY_CATEGORIES = [
  Category(
    id: 'c100',
    title: 'Café da Manhã',
    tipo: 'ref',
    color: Colors.red,
  ),
  Category(
    id: 'c200',
    title: 'Almoço',
    tipo: 'ref',
    color: Colors.red,
  ),
  Category(
    id: 'c300',
    title: 'Jantar',
    tipo: 'ref',
    color: Colors.red,
  ),
  Category(
    id: 's1',
    title: 'Serviço de quarto',
    tipo: 'serv',
    color: Colors.red,
  ),
];

const DUMMY_SERVICO = [];

const DUMMY_MEALS = [
  Meal(
    id: 's1',
    title: 'Serviço de quarto',
    categories: ['s1'],
    imageUrl:
        'https://cdn.sanity.io/images/tbvc1g2x/production/e48f7be484d6838b1812cbebcbbcf068b8581bfc-1600x1067.jpg?w=1600&h=1067&auto=format',
    duration: 50,
    affordability: Affordability.Affordable,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Meal(
    id: 'm12',
    title: 'Croissant de chocolate',
    categories: ['c100'],
    imageUrl:
        'https://images.unsplash.com/photo-1530610476181-d83430b64dcd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
    duration: 30,
    affordability: Affordability.Affordable,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Meal(
    id: 'm13',
    title: 'Iogurte com cereais e frutas',
    categories: ['c100'],
    imageUrl:
        'https://images.unsplash.com/photo-1581559178851-b99664da71ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
    duration: 20,
    affordability: Affordability.Affordable,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Meal(
    id: 'm11',
    title: 'Torrada e ovo frito',
    categories: ['c100'],
    imageUrl:
        'https://images.unsplash.com/photo-1525351484163-7529414344d8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
    duration: 25,
    affordability: Affordability.Affordable,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Meal(
    id: 'm14',
    title: 'Carne assada com vegetais',
    categories: ['c200', 'c300'],
    imageUrl:
        'https://images.unsplash.com/photo-1573225342350-16731dd9bf3d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=762&q=80',
    duration: 60,
    affordability: Affordability.Pricey,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Meal(
    id: 'm18',
    title: 'Pizza de quatro quejos',
    categories: ['c300'],
    imageUrl:
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    duration: 60,
    affordability: Affordability.Affordable,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Meal(
    id: 'm16',
    title: 'Fusilli com tomates',
    categories: ['c200'],
    imageUrl:
        'https://images.unsplash.com/photo-1608897013039-887f21d8c804?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=392&q=80',
    duration: 50,
    affordability: Affordability.Affordable,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Meal(
    id: 'm17',
    title: 'Sopa de abobrinha com salmão',
    categories: ['c300'],
    imageUrl:
        'https://images.unsplash.com/photo-1467003909585-2f8a72700288?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
    duration: 80,
    affordability: Affordability.Luxurious,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Meal(
    id: 'm15',
    title: 'Salada com croutons',
    categories: ['c200', 'c300'],
    imageUrl:
        'https://images.unsplash.com/photo-1546793665-c74683f339c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    duration: 20,
    affordability: Affordability.Affordable,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Meal(
    id: 'm19',
    title: 'Spaghetti com almôndegas',
    categories: ['c200', 'c300'],
    imageUrl:
        'https://images.unsplash.com/photo-1515516969-d4008cc6241a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
    duration: 60,
    affordability: Affordability.Pricey,
    isGlutenFree: false,
    isLactoseFree: false,
    isVegan: false,
    isVegetarian: false,
    price: 15.00,
  ),
  Meal(
    id: 'm1',
    categories: [
      'c200',
      'c300',
    ],
    title: 'Spaghetti com Molho de Tomate',
    affordability: Affordability.Affordable,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
    duration: 40,
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    price: 15.00,
  ),
  Meal(
    id: 'm2',
    categories: [
      'c100',
    ],
    title: 'Torradas Havaianas',
    affordability: Affordability.Affordable,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
    duration: 10,
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    price: 15.00,
  ),
  Meal(
    id: 'm3',
    categories: [
      'c200',
      'c300',
    ],
    title: 'Hamburguer clássico',
    affordability: Affordability.Pricey,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    duration: 45,
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    price: 15.00,
  ),
  Meal(
    id: 'm4',
    categories: [
      'c200',
      'c300',
    ],
    title: 'Wiener Schnitzel',
    affordability: Affordability.Luxurious,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg',
    duration: 60,
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    price: 15.00,
  ),
  Meal(
    id: 'm5',
    categories: [
      'c200',
      'c300',
    ],
    title: 'Salada com Salmão Defumado',
    affordability: Affordability.Luxurious,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
    duration: 30,
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: true,
    price: 15.00,
  ),
  Meal(
    id: 'm6',
    categories: [
      'c200',
    ],
    title: 'Mousse de Laranja',
    affordability: Affordability.Affordable,
    imageUrl:
        'https://cdn.pixabay.com/photo/2017/05/01/05/18/pastry-2274750_1280.jpg',
    duration: 40,
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    price: 15.00,
  ),
  Meal(
    id: 'm7',
    categories: [
      'c100',
    ],
    title: 'Panqueca Americana',
    affordability: Affordability.Affordable,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/10/21/23/pancake-3529653_1280.jpg',
    duration: 30,
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    price: 15.00,
  ),
  Meal(
    id: 'm8',
    categories: [
      'c300',
    ],
    title: 'Chicken Curry Indiano',
    affordability: Affordability.Pricey,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/06/18/16/05/indian-food-3482749_1280.jpg',
    duration: 55,
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    price: 15.00,
  ),
  Meal(
    id: 'm9',
    categories: [
      'c300',
    ],
    title: 'Suflê de Chocolate',
    affordability: Affordability.Affordable,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/08/07/21/07/souffle-412785_1280.jpg',
    duration: 30,
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    price: 15.00,
  ),
  Meal(
    id: 'm10',
    categories: [
      'c300',
      'c200',
    ],
    title: 'Salada de Aspargos com Tomate Cereja',
    affordability: Affordability.Luxurious,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/04/09/18/26/asparagus-3304997_1280.jpg',
    duration: 30,
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    price: 15.00,
  ),
];

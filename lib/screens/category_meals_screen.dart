import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/refeicao.dart';
import '../globals.dart' as globals;

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  const CategoryMealsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getImageUrl(String nome) {
      List<Refeicao> ref =
          refeitcoesList.where((element) => element.title == nome).toList();
      return ref[0].imageUrl;
    }

    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryMeals = globals.servicoList.where((servico) {
      return servico['tipo'] == categoryTitle;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, index) {
          return RefeicaoItem(
            id: categoryMeals[index]['_id'],
            title: categoryMeals[index]['nome'],
            imageUrl: getImageUrl(categoryMeals[index]['nome']),
            duration: 30,
            price: double.parse(categoryMeals[index]['preco'].toString()),
          );
        },
      ),
    );
  }
}

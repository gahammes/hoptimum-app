import 'package:flutter/material.dart';

import '../models/data/refeicoes_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  static const routeName = '/categories-screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final Ctitle = routeArgs['title'];
    final cTipo = routeArgs['tipo'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(Ctitle!),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 25,
          mainAxisSpacing: 25,
        ),
        children: DUMMY_CATEGORIES
            .where((cat) {
              return cat.tipo.contains(cTipo!);
            })
            .map((catData) => CategoryItem(
                  catData.id,
                  catData.title,
                  catData.tipo,
                  catData.color,
                ))
            .toList(),
      ),
    );
  }
}

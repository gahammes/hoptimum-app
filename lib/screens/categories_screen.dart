import 'package:flutter/material.dart';

import '../widgets/category_item.dart';
import '../models/solicitacao.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  static const routeName = '/categories-screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final ctitle = routeArgs['title'];
    final cTipo = routeArgs['tipo'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(ctitle!),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 25,
          mainAxisSpacing: 25,
        ),
        children: solicitacaoCategories
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

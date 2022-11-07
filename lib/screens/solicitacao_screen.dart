import 'package:dashboard_tcc/models/solicitacao.dart';
import 'package:dashboard_tcc/widgets/solicitacao_item.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/data/refeicoes_data.dart';
import '../widgets/category_item.dart';

class SolicitacaoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
      ),
      children: SOLICITACAO
          .map((catData) => SolicitacaoItem(
                catData.id,
                catData.title,
                catData.tipo,
                catData.color,
              ))
          .toList(),
    );
  }
}

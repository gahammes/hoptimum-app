import 'package:flutter/material.dart';

import '../widgets/solicitacao_item.dart';
import '../models/solicitacao.dart';

class SolicitacaoScreen extends StatelessWidget {
  const SolicitacaoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
      ),
      children: solicitacaoCategories
          .map(
            (catData) => SolicitacaoItem(
              catData.id,
              catData.title,
              catData.tipo,
              catData.color,
            ),
          )
          .toList(),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/refeicao.dart';
import '../screens/meal_detail_screen.dart';

class RefeicaoItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Preco affordability;
  final double price;

  const RefeicaoItem({
    Key? key,
    required this.id,
    required this.affordability,
    required this.duration,
    required this.imageUrl,
    required this.title,
    required this.price,
  }) : super(key: key);

  // String get affordabilitytext {
  //   switch (affordability) {
  //     case Preco.barato:
  //       return 'Affordable';
  //     case Preco.razoavel:
  //       return 'Pricey';
  //     case Preco.caro:
  //       return 'Luxurious';
  //     default:
  //       return 'Unknown';
  //   }
  // }

  Widget affordabilityIcons(BuildContext context) {
    final iconColorOrange = Theme.of(context).colorScheme.primary;
    final iconColorGrey = Colors.grey[700];

    switch (affordability) {
      case Preco.barato:
        return Row(
          children: [
            Icon(
              Icons.attach_money,
              color: iconColorOrange,
              //size: 20,
            ),
            Icon(
              Icons.attach_money,
              color: iconColorGrey,
            ),
            Icon(
              Icons.attach_money,
              color: iconColorGrey,
            ),
          ],
        );
      case Preco.razoavel:
        return Row(
          children: [
            Icon(
              Icons.attach_money,
              color: iconColorOrange,
            ),
            Icon(
              Icons.attach_money,
              color: iconColorOrange,
            ),
            Icon(
              Icons.attach_money,
              color: iconColorGrey,
            ),
          ],
        );
      case Preco.caro:
        return Row(
          children: [
            Icon(
              Icons.attach_money,
              color: iconColorOrange,
            ),
            Icon(
              Icons.attach_money,
              color: iconColorOrange,
            ),
            Icon(
              Icons.attach_money,
              color: iconColorOrange,
            ),
          ],
        );
      default:
        return Row(
          children: [
            Icon(
              Icons.attach_money,
              color: iconColorGrey,
            ),
            Icon(
              Icons.attach_money,
              color: iconColorGrey,
            ),
            Icon(
              Icons.attach_money,
              color: iconColorGrey,
            ),
            Icon(
              Icons.attach_money,
              color: iconColorGrey,
            ),
            Icon(
              Icons.attach_money,
              color: iconColorGrey,
            ),
          ],
        );
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
      MealDetailScreen1.routeName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.primary;
    const fontColor = Colors.white;
    return InkWell(
      //onTap: () => selectMeal(context),
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 5,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: 10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: iconColor,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            '$duration min',
                            style: const TextStyle(
                              color: fontColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: affordabilityIcons(context),
                      ),
                      Row(
                        children: [
                          Text(
                            'R\$ ',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            price.toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      )
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.work,
                      //     ),
                      //     SizedBox(
                      //       width: 6,
                      //     ),
                      //     Text(complexityText),
                      //   ],
                      // ),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.attach_money,
                      //     ),
                      //     SizedBox(
                      //       width: 6,
                      //     ),
                      //     Text(affordabilitytext),
                      //   ],
                      // ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: const Text(
                            'PEDIR',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ),
                  //TODO: colocar aqui as tags de veggie etc
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

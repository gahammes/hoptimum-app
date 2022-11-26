import 'package:flutter/material.dart';
import 'package:hoptimum/widgets/custom_rect_tween.dart';
import 'package:hoptimum/widgets/hero_dialog_route.dart';
import 'package:hoptimum/widgets/hospede_info_card.dart';
import 'package:hoptimum/widgets/reserva_info_card.dart';

import '../screens/info_hospede_screen.dart';
import '../globals.dart' as globals;

class CardsList extends StatelessWidget {
  final String nome;
  final String tipo;
  final String info;
  final String carro;
  final String tag;
  final Map hospede;
  final bool titular;

  const CardsList(this.nome, this.tipo, this.info, this.carro, this.tag,
      this.hospede, this.titular,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      margin: const EdgeInsets.fromLTRB(70, 16, 10, 0),
      constraints: const BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 4,
          ),
          FittedBox(
            child: Text(
              nome,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            height: 2,
          ),
          Text(
            tipo,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14.0),
            height: 1.0,
            width: 25.0,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Text(
            info,
            style: const TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 15,
            ),
          ),
          Container(
            height: 6,
          ),
          Text(
            carro,
            style: const TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );

    final profilePhoto = Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      alignment: FractionalOffset.centerLeft,
      child: const Image(
        image: AssetImage('assets/images/profile.png'),
        height: 110,
        width: 110,
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            duration: 200,
            builder: (context) {
              return HospedeInfoCard(tag, hospede, titular);
            },
          ),
        );
      },
      child: Hero(
        tag: tag,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          height: 120.0,
          child: Stack(
            children: [
              Container(
                child: Material(
                  type: MaterialType.transparency,
                  child: cardContent,
                ),
                height: 155.0,
                margin: const EdgeInsets.only(
                  top: 20.0,
                  left: 50.0,
                ),
                decoration: BoxDecoration(
                  //color: Theme.of(context).colorScheme.primary,
                  gradient: const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Color.fromARGB(255, 255, 135, 108),
                      Color.fromARGB(255, 248, 128, 101),
                      Color.fromARGB(255, 246, 106, 75),
                      Color(0xffF75E3B),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
              ),
              profilePhoto,
            ],
          ),
        ),
      ),
    );
  }
}

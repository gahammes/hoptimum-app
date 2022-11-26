import 'package:flutter/material.dart';

import '../models/hospede.dart';

class ListaHospedes extends StatefulWidget {
  final List hospedes;
  const ListaHospedes(this.hospedes, {Key? key}) : super(key: key);
  @override
  State<ListaHospedes> createState() => _ListaHospedesState();
}

class _ListaHospedesState extends State<ListaHospedes> {
  Widget _buildExpansionTile(int index, Color color) {
    return ExpansionTile(
      maintainState: true,
      collapsedBackgroundColor: const Color(0xfff5f5f5),
      backgroundColor: const Color(0xfff5f5f5),
      //collapsedBackgroundColor: Colors.white,
      title: const Text(
        'Detalhes',
        style: TextStyle(fontSize: 16),
      ),
      textColor: Theme.of(context).colorScheme.primary,
      childrenPadding:
          const EdgeInsets.only(left: 16.0, bottom: 10.0, right: 10.0),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      children: [
        _buildRichText('Titular: ', widget.hospedes[index].nome),
        const SizedBox(height: 7.0),
        _buildRichText('CPF: ', widget.hospedes[index].cpf),
        const SizedBox(height: 7.0),
        _buildRichText('Telefone: ', widget.hospedes[index].telefone),
        const SizedBox(height: 7.0),
        _buildRichText('Email: ', widget.hospedes[index].email),
        const SizedBox(height: 7.0),
        _buildListCartoes(widget.hospedes[index].reserva.cartoes),
        const SizedBox(height: 7.0),
        _buildListCarros(widget.hospedes[index].carro),
        const SizedBox(height: 7.0),
        _buildListDependentes(index),
      ],
    );
  }

  Widget _buildRichText(String title, String subtitle) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            fontSize: 16, fontFamily: 'Quicksand', color: Colors.black),
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: subtitle),
        ],
      ),
    );
  }

  Widget _buildListCartoes(List<String> cartoes) {
    return cartoes.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartoes.length == 1 ? 'Cartão-chave: ' : 'Cartões-chave:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              for (var cartao in cartoes)
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Código: $cartao',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
            ],
          )
        : const SizedBox(height: 0);
  }

  Widget _buildListCarros(List<Carro> carros) {
    return carros.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                carros.length == 1 ? 'Carro: ' : 'Carros:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              for (var carro in carros)
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        '${carro.modelo} - Placa: ',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      // margin: const EdgeInsets.only(left: 20.0, bottom: 5.0),
                      child: Text(
                        carro.placa,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
            ],
          )
        : const SizedBox(height: 0);
  }

  Widget _buildListDependentes(int index) {
    return widget.hospedes[index].dependentes.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.hospedes[index].dependentes.length == 1
                    ? 'Dependente:'
                    : 'Dependentes:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5.0,
              ),
              for (var dependente in widget.hospedes[index].dependentes)
                Container(
                  margin: const EdgeInsets.only(left: 20.0, bottom: 5.0),
                  child: Text(
                    dependente.nome,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
            ],
          )
        : const SizedBox(height: 0);
  }

  Widget _buildCard(int index) {
    var bgColor = Theme.of(context).colorScheme.secondary;
    var fontColor = Colors.white;

    return Container(
      margin: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: bgColor,
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Column(
          children: [
            ListTile(
                leading: SizedBox(
                  //width: 85,
                  height: 60,
                  child: Card(
                    color: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FittedBox(
                      child: Container(
                        decoration: BoxDecoration(
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
                          borderRadius: BorderRadius.circular(15),
                        ),
                        // margin: const EdgeInsets.symmetric(
                        //   vertical: 10,
                        //   horizontal: 8,
                        // ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  'Quarto ${widget.hospedes[index].reserva.quarto}',
                  style: TextStyle(
                    color: fontColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  widget.hospedes[index].nome,
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: null),
            _buildExpansionTile(
              index,
              fontColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.hospedes.length,
        itemBuilder: (context, index) {
          return _buildCard(index);
        });
  }
}

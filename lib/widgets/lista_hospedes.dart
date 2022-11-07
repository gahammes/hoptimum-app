import 'package:dashboard_tcc/models/hospede.dart';
import 'package:dashboard_tcc/models/pedido.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListaHospedes extends StatefulWidget {
  List<Hospede> hospedes;
  ListaHospedes(this.hospedes, {Key? key}) : super(key: key);
  @override
  State<ListaHospedes> createState() => _ListaHospedesState();
}

class _ListaHospedesState extends State<ListaHospedes> {
  Widget _buildExpansionTile(int index, Color color) {
    return ExpansionTile(
      maintainState: true,
      collapsedBackgroundColor: Color(0xfff5f5f5),
      backgroundColor: Color(0xfff5f5f5),
      //collapsedBackgroundColor: Colors.white,
      title: Text(
        'Detalhes',
        style: TextStyle(fontSize: 16),
      ),
      textColor: Theme.of(context).colorScheme.primary,
      childrenPadding: EdgeInsets.only(left: 16.0, bottom: 10.0, right: 10.0),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      children: [
        _buildRichText('Titular: ', widget.hospedes[index].nome),
        SizedBox(height: 7.0),
        _buildRichText('CPF: ', widget.hospedes[index].cpf),
        SizedBox(height: 7.0),
        _buildRichText('Telefone: ', widget.hospedes[index].telefone),
        SizedBox(height: 7.0),
        _buildRichText('Email: ', widget.hospedes[index].email),
        SizedBox(height: 7.0),
        _buildListaCartoes(widget.hospedes[index].reserva.numCartaoChave),
        SizedBox(height: 7.0),
        _buildRichText('Placa do carro: ', widget.hospedes[index].carro.placa),
        SizedBox(height: 7.0),
        _buildListDependentes(index),
      ],
    );
  }

  Widget _buildListaCartoes(List<int> numLista) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
            fontSize: 16, fontFamily: 'Quicksand', color: Colors.black),
        children: [
          TextSpan(
            text: 'Cartões-Chave: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          for (var i = 0; i < numLista.length; i++)
            TextSpan(
                text: i != (numLista.length - 1)
                    ? '${numLista[i]}, '
                    : '${numLista[i]}'),
        ],
      ),
    );
  }

  Widget _buildRichText(String title, String subtitle) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
            fontSize: 16, fontFamily: 'Quicksand', color: Colors.black),
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: subtitle),
        ],
      ),
    );
  }

  Widget _buildListDependentes(int index) {
    return widget.hospedes[index].dependentes.length != 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dependentes: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              for (var dependente in widget.hospedes[index].dependentes)
                Container(
                  margin: EdgeInsets.only(left: 20.0, bottom: 5.0),
                  child: Text(
                    dependente.nome,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
            ],
          )
        : SizedBox(height: 0);
  }

  Widget _buildCard(int index) {
    var bgColor = Theme.of(context).colorScheme.secondary;
    var fontColor = Colors.white;

    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: bgColor,
        elevation: 5,
        margin: EdgeInsets.symmetric(
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
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      child: Icon(
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
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
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
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1), () {
          setState(() {});
        });
      },
      child: ListView.builder(
          itemCount: widget.hospedes.length,
          itemBuilder: (context, index) {
            return _buildCard(index);
          }),
    );
  }
}

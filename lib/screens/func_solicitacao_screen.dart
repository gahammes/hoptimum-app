import 'package:flutter/material.dart';
import 'package:hoptimum/models/seguranca.dart';
import 'package:hoptimum/widgets/seguranca_list.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import '../globals.dart' as globals;
import '../models/pedido.dart';
import '../models/providers/auth.dart';
import '../widgets/func_solicitacao_item.dart';

class FuncSolicitacaoScreen extends StatefulWidget {
  static const routeName = '/funcSolicitacao-screen';

  const FuncSolicitacaoScreen({Key? key}) : super(key: key);

  @override
  State<FuncSolicitacaoScreen> createState() => _FuncSolicitacaoScreenState();
}

class _FuncSolicitacaoScreenState extends State<FuncSolicitacaoScreen>
    with TickerProviderStateMixin {
  static const List<Tab> myTabs = [
    Tab(
      icon: Icon(Icons.restaurant),
    ),
    Tab(
      icon: Icon(Icons.history),
    ),
    Tab(
      icon: Icon(Icons.shield),
    ),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _logout() {
      Provider.of<Auth>(context, listen: false).logout();
      Navigator.of(context).pushReplacementNamed('/');
    }

    initializeDateFormatting();
    return Scaffold(
      appBar: AppBar(
        title: Text('${globals.loginData['funcionario']['nome']} - Cozinha'
            .toUpperCase()),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Colors.grey.withOpacity(0.6),
          indicatorColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.7),
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        child: TabBarView(
          controller: _tabController,
          children: [
            //TODO:LISTA DE PEDIDOS
            SingleChildScrollView(
              child: Container(
                height: 647,
                padding: const EdgeInsets.all(0.0),
                child: pedidosList.isNotEmpty
                    ? ListView.builder(
                        key: UniqueKey(),
                        itemCount: pedidosList.length,
                        itemBuilder: (context, index) {
                          return FuncSolicitacaoItem(
                            pedidosList[index].id,
                            pedidosList[index].refeicao,
                            pedidosList[index].numQuarto,
                            pedidosList[index].data,
                            pedidosList[index].status,
                          );
                        },
                      )
                    : null,
                //child: FuncLimpezaItem(servicosList, servicosFinalizadosList),
              ),
            ),
            //HISTORICO DE PEDIDOS
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(0.0),
                height: 640,
                child: pedidosFinalizadosList.isNotEmpty
                    ? ListView.builder(
                        itemCount: pedidosFinalizadosList.length,
                        itemBuilder: (context, index) {
                          return FuncSolicitacaoItem(
                            pedidosFinalizadosList[index].id,
                            pedidosFinalizadosList[index].refeicao,
                            pedidosFinalizadosList[index].numQuarto,
                            pedidosFinalizadosList[index].data,
                            pedidosFinalizadosList[index].status,
                          );
                        },
                      )
                    : null,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 640, //TODO: aqui da overflow MENTIRA
                    //margin: EdgeInsets.only(top: 0),
                    child: SegurancaList(segurancaLog),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

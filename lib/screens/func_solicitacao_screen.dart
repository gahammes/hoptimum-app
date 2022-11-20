import 'package:flutter/material.dart';
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
    // Tab(
    //   icon: Icon(Icons.tag),
    // ),
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

    //TODO:ROTA DO COISO
    print(globals.loginData['funcionario']['cargo']);

    initializeDateFormatting();
    //print(globals.loginData['funcionario']['cartoesChave']);
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
                child: FuncSolicitacaoItem(pedidosList, pedidosFinalizadosList),
              ),
            ),
            //HISTORICO DE PEDIDOS
            SingleChildScrollView(
              child: Container(
                height: 647,
                padding: const EdgeInsets.all(0.0),
                child: FuncSolicitacaoItem(
                    pedidosFinalizadosList, pedidosFinalizadosList),
              ),
            ),
            //TODO: historico do cartao aqui!!!
            // SingleChildScrollView(
            //   child: Container(
            //     height: 647,
            //     padding: EdgeInsets.all(0.0),
            //     child: FuncSolicitacaoItem(
            //         PEDIDOS_FINALIZADOS, PEDIDOS_FINALIZADOS),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

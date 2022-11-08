import 'package:dashboard_tcc/models/pedido.dart';
import 'package:dashboard_tcc/models/providers/auth.dart';
import 'package:dashboard_tcc/widgets/funcSolicitacao_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';
import '../globals.dart' as globals;

class FuncSolicitacaoScreen extends StatefulWidget {
  static const routeName = '/funcSolicitacao-screen';

  @override
  State<FuncSolicitacaoScreen> createState() => _FuncSolicitacaoScreenState();
}

class _FuncSolicitacaoScreenState extends State<FuncSolicitacaoScreen>
    with TickerProviderStateMixin {
  static const List<Tab> myTabs = [
    Tab(
      icon: Icon(Icons.home),
    ),
    Tab(
      icon: Icon(Icons.history),
    ),
    Tab(
      icon: Icon(Icons.tag),
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
    print(globals.loginData['funcionario']['cartoesChave']);
    return Scaffold(
      appBar: AppBar(
        title: Text('${globals.loginData['funcionario']['nome']} - Cozinha'
            .toUpperCase()),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(
              onPressed: _logout,
              icon: Icon(
                Icons.logout,
                color: Colors.red,
              ))
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
            SingleChildScrollView(
              child: Container(
                height: 647,
                padding: EdgeInsets.all(0.0),
                child: FuncSolicitacaoItem(PEDIDOS, PEDIDOS_FINALIZADOS),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: 647,
                padding: EdgeInsets.all(0.0),
                child: FuncSolicitacaoItem(
                    PEDIDOS_FINALIZADOS, PEDIDOS_FINALIZADOS),
              ),
            ),
            //TODO: historico do cartao aqui!!!
            SingleChildScrollView(
              child: Container(
                height: 647,
                padding: EdgeInsets.all(0.0),
                child: FuncSolicitacaoItem(
                    PEDIDOS_FINALIZADOS, PEDIDOS_FINALIZADOS),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dashboard_tcc/models/data/seguranca_data.dart';
import 'package:dashboard_tcc/models/pedido.dart';
import 'package:dashboard_tcc/models/providers/auth.dart';
import 'package:dashboard_tcc/models/servico.dart';
import 'package:dashboard_tcc/widgets/funcLimpeza_item.dart';
import 'package:dashboard_tcc/widgets/funcSolicitacao_item.dart';
import 'package:dashboard_tcc/widgets/seguranca_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import '../globals.dart' as globals;
import 'login_screen.dart';

class FuncLimpezaScreen extends StatefulWidget {
  static const routeName = '/funcLimpeza-screen';

  @override
  State<FuncLimpezaScreen> createState() => _FuncLimpezaScreenState();
}

class _FuncLimpezaScreenState extends State<FuncLimpezaScreen>
    with TickerProviderStateMixin {
  static const List<Tab> myTabs = [
    Tab(
      icon: Icon(Icons.king_bed),
    ),
    Tab(
      icon: Icon(Icons.tag),
    ),
    Tab(
      icon: Icon(Icons.history),
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

    print(globals.loginData['funcionario']['cartoesChave']);

    initializeDateFormatting();
    return Scaffold(
      appBar: AppBar(
        title: Text('${globals.loginData['funcionario']['nome']} - Limpeza'
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
                child: FuncLimpezaItem(SERVICOS, SERVICOS_FINALIZADOS),
              ),
            ),
            //TODO: historico do cartao aqui!!!
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 640, //TODO: aqui da overflow
                    //margin: EdgeInsets.only(top: 0),
                    child: SEGURANCA_DATA.isEmpty
                        ? null
                        : SegurancaList(
                            SEGURANCA_DATA), //TODO:tratar na main.dart
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: 647,
                padding: EdgeInsets.all(0.0),
                child:
                    FuncLimpezaItem(SERVICOS_FINALIZADOS, SERVICOS_FINALIZADOS),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

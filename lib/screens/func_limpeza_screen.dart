import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import '../models/providers/auth.dart';
import '../models/servico.dart';
import '../widgets/func_limpeza_item.dart';
import '../widgets/seguranca_list.dart';
import '../globals.dart' as globals;
import '../../models/seguranca.dart';

class FuncLimpezaScreen extends StatefulWidget {
  static const routeName = '/funcLimpeza-screen';

  const FuncLimpezaScreen({Key? key}) : super(key: key);

  @override
  State<FuncLimpezaScreen> createState() => _FuncLimpezaScreenState();
}

class _FuncLimpezaScreenState extends State<FuncLimpezaScreen>
    with TickerProviderStateMixin {
  static const List<Tab> myTabs = [
    Tab(
      icon: Icon(Icons.airline_seat_individual_suite_rounded),
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
        title: Text('${globals.loginData['funcionario']['nome']} - Limpeza'
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
            SingleChildScrollView(
              child: Container(
                height: 647,
                padding: const EdgeInsets.all(0.0),
                child: servicosList.isNotEmpty
                    ? ListView.builder(
                        key: UniqueKey(),
                        itemCount: servicosList.length,
                        itemBuilder: (context, index) {
                          return FuncLimpezaItem(
                            servicosList[index].id,
                            servicosList[index].title,
                            servicosList[index].numQuarto,
                            servicosList[index].data,
                            servicosList[index].status,
                          );
                        },
                      )
                    : null,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(0.0),
                height: 640,
                child: servicosFinalizadosList.isNotEmpty
                    ? ListView.builder(
                        itemCount: servicosFinalizadosList.length,
                        itemBuilder: (context, index) {
                          return FuncLimpezaItem(
                            servicosFinalizadosList[index].id,
                            servicosFinalizadosList[index].title,
                            servicosFinalizadosList[index].numQuarto,
                            servicosFinalizadosList[index].data,
                            servicosFinalizadosList[index].status,
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
                    height: 640,
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

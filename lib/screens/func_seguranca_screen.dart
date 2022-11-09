import 'package:dashboard_tcc/models/data/seguranca_data.dart';
import 'package:dashboard_tcc/models/hospede.dart';
import 'package:dashboard_tcc/models/providers/auth.dart';
import 'package:dashboard_tcc/models/report.dart';
import 'package:dashboard_tcc/widgets/lista_hospedes.dart';
import 'package:dashboard_tcc/widgets/report_card.dart';
import 'package:dashboard_tcc/widgets/seguranca_list.dart';
import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import '../globals.dart' as globals;

class FuncSegurancaScreen extends StatefulWidget {
  static const routeName = '/funcSeguranca-screen';

  @override
  State<FuncSegurancaScreen> createState() => _FuncSegurancaScreenState();
}

class _FuncSegurancaScreenState extends State<FuncSegurancaScreen>
    with TickerProviderStateMixin {
  static const List<Tab> myTabs = [
    Tab(
      icon: Icon(Icons.notification_important),
    ),
    Tab(
      icon: Icon(Icons.key),
    ),
    Tab(
      icon: Icon(Icons.list),
    ),
  ];

  late TabController _tabController;

  void _logout() {
    Provider.of<Auth>(context, listen: false).logout();
    Navigator.of(context).pushReplacementNamed('/');
  }

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

  void printCoiso() {
    print(globals.loginData['funcionario']['registros']);
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    //printCoiso();
    //print(globals.loginData['funcionario']['cartoesChave']);
    return Scaffold(
      appBar: AppBar(
        title: Text('${globals.loginData['funcionario']['nome']} - Segurança'
            .toUpperCase()),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: Icon(
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
        //margin: EdgeInsets.all(10.0),
        color: Colors.grey[300],
        child: TabBarView(
          controller: _tabController,
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: 648,
                child: RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(Duration(seconds: 1), () {
                      setState(() {});
                    });
                  },
                  child: ListView.builder(
                    itemCount: REPORTES.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10,
                          bottom: 0,
                        ),
                        child: ReportCard(REPORTES[index]),
                      );
                    },
                  ),
                ),
              ),
            ),
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
                child: ListaHospedes(HOSPEDES),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
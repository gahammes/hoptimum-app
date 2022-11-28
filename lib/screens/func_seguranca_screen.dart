import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hoptimum/models/seguranca.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/hospede.dart';
import '../models/providers/auth.dart';
import '../models/report.dart';
import '../widgets/lista_hospedes.dart';
import '../widgets/report_card.dart';
import '../widgets/seguranca_list.dart';
import '../globals.dart' as globals;

class FuncSegurancaScreen extends StatefulWidget {
  static const routeName = '/funcSeguranca-screen';

  const FuncSegurancaScreen({Key? key}) : super(key: key);

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
      icon: Icon(Icons.shield),
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

    return Scaffold(
      appBar: AppBar(
        title: Text('${globals.loginData['funcionario']['nome']} - Segurança'
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
                    return Future.delayed(const Duration(seconds: 1), () {
                      setState(() {});
                    });
                  },
                  child: ListView.builder(
                    itemCount: reportesList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10,
                          bottom: 0,
                        ),
                        child: ReportCard(reportesList[index]),
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
                  SizedBox(
                    height: 640, //TODO: aqui da overflow
                    //margin: EdgeInsets.only(top: 0),

                    child: SegurancaList(segurancaLog),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: 647,
                padding: const EdgeInsets.all(0.0),
                child: ListaHospedes(hospedeList),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hoptimum/models/seguranca.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/providers/auth.dart';
import '../models/servico.dart';
import '../widgets/func_limpeza_item.dart';
import '../widgets/seguranca_list.dart';
import '../globals.dart' as globals;

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
      icon: Icon(Icons.key),
    ),
    Tab(
      icon: Icon(Icons.history),
    ),
  ];

  late TabController _tabController;

  void printFunc() {
    print(globals.loginData);
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

  void printCoisas() {
    print(globals.loginData);
  }

  void getServList() async {
    // final url = Uri.parse(globals.getUrl('http', 'api/servicos'));
    // final response = await http.get(url);
    // globals.servList = json.decode(response.body);
    print(globals.servicoList);
  }

  @override
  Widget build(BuildContext context) {
    void _logout() {
      Provider.of<Auth>(context, listen: false).logout();
      Navigator.of(context).pushReplacementNamed('/');
    }

    //print(globals.loginData['funcionario']['servicos']);
    getServList();

    initializeDateFormatting();
    print(globals.loginData['funcionario']['carros']);
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
                child: FuncLimpezaItem(servicosList, servicosFinalizadosList),
              ),
            ),
            //TODO: historico do cartao aqui!!!
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 640, //TODO: aqui da overflow MENTIRA
                    //margin: EdgeInsets.only(top: 0),
                    child: segurancaLog.isEmpty
                        ? null
                        : SegurancaList(
                            segurancaLog), //TODO:tratar na main.dart
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: 647,
                padding: const EdgeInsets.all(0.0),
                child: FuncLimpezaItem(
                    servicosFinalizadosList, servicosFinalizadosList),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

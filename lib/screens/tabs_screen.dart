import 'package:dashboard_tcc/models/data/despesas_data.dart';
import 'package:dashboard_tcc/models/data/seguranca_data.dart';
import 'package:dashboard_tcc/models/providers/auth.dart';
import 'package:dashboard_tcc/screens/configuracoes_screen.dart';
import 'package:dashboard_tcc/screens/despesas_screen.dart';
import 'package:dashboard_tcc/screens/home_screen.dart';
import 'package:dashboard_tcc/screens/login_screen.dart';
import 'package:dashboard_tcc/screens/notificacao_screen.dart';
import 'package:dashboard_tcc/screens/seguranca_screen.dart';
import 'package:dashboard_tcc/screens/tela_reserva.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:convert';

import '../models/transaction.dart';
import '../widgets/new_transactions.dart';
import 'categories_screen.dart';
import 'solicitacao_screen.dart';
import 'package:dashboard_tcc/globals.dart' as globals;
import '../models/seguranca.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _selectedPageIndex = 0;

  var _userTransactions = DESPESAS_DATA;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _logout() {
    Provider.of<Auth>(context, listen: false).logout();
    // Future.delayed(Duration.zero, () {
    //   Navigator.of(context).pop();
    // });
    // SchedulerBinding.instance!.addPostFrameCallback((_) {
    //   Navigator.of(context).pop();

    // });
    //Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed('/');
    //Provider.of<Auth>(context, listen: false).logout();
  }

  void _settings() {
    Navigator.of(context).pushNamed(ConfiguracoesScreen.routeName);
  }

  void _refresh() {
    setState(() {
      //TODO: fazer a lógica
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => this.widget,
          ));
    });
  }

  void _refresh1() {
    // var url =
    //     'http://b850-2804-7f4-3590-1900-91ab-d012-172e-5985.sa.ngrok.io/api';
    // var access = getString(url);
    // access.then(handleContent);
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (contex) => AlertDialog(
          title: const Text(
            'Descreva o problema',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontFamily: 'Quicksand'),
          ),
          content: TextField(
            maxLines: null,
            autofocus: true,
            onSubmitted: (_) => submitInput(),
            //controller: inputController,
            maxLength: 100,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Digite aqui...',
              hintStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Quicksand',
                fontSize: 12,
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  //inputController.clear();
                },
                child: Text('Cancelar')),
            TextButton(onPressed: submitInput, child: Text('Enviar')),
          ],
        ),
      );

  void submitInput() {
    Navigator.of(context).pop();
    //inputController.clear();
  }

  void _reservaRoute() {
    Navigator.of(context).pushNamed(TelaReserva.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _pages = [
      {
        'page': HomePage(),
        'title': 'Home',
        'actions': [
          IconButton(
            onPressed: _reservaRoute,
            icon: Icon(Icons.hotel),
          ),
          IconButton(
            onPressed: _logout,
            icon: Icon(Icons.logout),
          ),
        ],
      },
      {
        'page': DespesasScreen(),
        'title': 'Despesas',
        'actions': [
          IconButton(
            onPressed: _refresh,
            icon: Icon(Icons.refresh),
          ),
        ],
      },
      {
        'page': SolicitacaoScreen(),
        'title': 'Solicitações',
        'actions': null,
      },
      {
        'page': NotificacaoScreen(),
        'title': 'Notificações',
        'actions': [
          IconButton(
            onPressed: _refresh,
            icon: Icon(Icons.refresh),
          ),
        ],
      },
      {
        'page': SegurancaScreen(),
        'title': 'Segurança',
        'actions': [
          IconButton(
            //padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () async {
              final userInput = await openDialog();
            },
            icon: Icon(
              Icons.report,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: _refresh1,
            icon: Icon(Icons.refresh),
          ),
        ],
      },
    ];

    final appBar = AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      // leading: IconButton(
      //   onPressed: () => {},
      //   icon: Icon(Icons.density_medium),
      // ),
      //TODO: fazer drawer
      title: Text(
        _pages[_selectedPageIndex]['title'],
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: _pages[_selectedPageIndex]['actions'],
    );

    final navBar = BottomNavigationBar(
      onTap: _selectPage,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      unselectedItemColor: Colors.white,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      currentIndex: _selectedPageIndex,
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(Icons.attach_money),
          label: 'Despesas',
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(Icons.add_circle),
          label: 'Solicitações',
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(Icons.notifications),
          label: 'Notificações',
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(Icons.shield),
          label: 'Segurança',
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Nome do Titular',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'hospede@email.com',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // Divider(
            //   color: Theme.of(context).colorScheme.secondary,
            // ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: _settings,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: Text(
                'Sair',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: navBar,
    );
  }
}

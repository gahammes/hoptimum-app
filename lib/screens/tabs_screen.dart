import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/providers/auth.dart';
import '../screens/despesas_screen.dart';
import '../screens/home_screen.dart';
import '../screens/notificacao_screen.dart';
import '../screens/seguranca_screen.dart';
import '../models/despesa.dart';
import '../screens/solicitacao_screen.dart';
import '../globals.dart' as globals;

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  void _selectPage(int index) {
    setState(() {
      globals.tabIndex = index;
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

  void _refresh() {
    setState(() {
      //TODO: fazer a lógica
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => widget,
          ));
    });
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
            decoration: const InputDecoration(
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
              child: const Text('Cancelar'),
            ),
            TextButton(onPressed: submitInput, child: const Text('Enviar')),
          ],
        ),
      );

  void submitInput() {
    Navigator.of(context).pop();
    //inputController.clear();
  }

  DateTime getDatas(String qual) {
    var reservas = globals.loginData as Map;
    return qual == 'checkIn'
        ? DateTime.parse(
            reservas['hospede']['reservas'][getIndex()]['reserva']['checkIn'])
        : DateTime.parse(
            reservas['hospede']['reservas'][getIndex()]['reserva']['checkOut']);
  }

  @override
  Widget build(BuildContext context) {
    var dataCheck = getDatas('checkIn').isAfter(DateTime.now());
    final List<Map<String, dynamic>> _pages = [
      {
        'page': const HomePage(),
        'title': 'Home',
        'actions': [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      },
      {
        'page': const DespesasScreen(),
        'title': 'Despesas',
        'actions': [
          IconButton(
            onPressed: _refresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      },
      {
        'page': const SolicitacaoScreen(),
        'title': 'Solicitações',
        'actions': null,
      },
      {
        'page': const NotificacaoScreen(),
        'title': 'Notificações',
        'actions': [
          IconButton(
            onPressed: _refresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      },
      {
        'page': const SegurancaScreen(),
        'title': 'Segurança',
        'actions': [
          IconButton(
            //padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () async {
              final userInput = await openDialog();
            },
            icon: const Icon(
              Icons.report,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: _refresh,
            icon: const Icon(Icons.refresh),
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
      title: Text(
        _pages[globals.tabIndex]['title'],
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: _pages[globals.tabIndex]['actions'],
    );

    final navBar = BottomNavigationBar(
      onTap: dataCheck ? null : _selectPage,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      unselectedItemColor: Colors.white,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      currentIndex: globals.tabIndex,
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: const Icon(
            Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(
            Icons.attach_money,
            color: (dataCheck ? Colors.grey : Colors.white),
          ),
          label: 'Despesas',
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(
            Icons.add_circle,
            color: (dataCheck ? Colors.grey : Colors.white),
          ),
          label: 'Solicitações',
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(
            Icons.notifications,
            color: (dataCheck ? Colors.grey : Colors.white),
          ),
          label: 'Notificações',
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(
            Icons.shield,
            color: (dataCheck ? Colors.grey : Colors.white),
          ),
          label: 'Segurança',
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: _pages[globals.tabIndex]['page'],
      bottomNavigationBar: navBar,
    );
  }
}

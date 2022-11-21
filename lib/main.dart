import 'package:flutter/material.dart';
import 'package:hoptimum/models/notificacao.dart';
import 'package:hoptimum/models/pedido.dart';
import 'package:hoptimum/models/servico.dart';
import 'package:hoptimum/screens/cadastro_carro_screen.dart';
import 'package:hoptimum/screens/cadastro_dependente_screen.dart';
import 'package:hoptimum/screens/cadastro_screen.dart';
import 'package:hoptimum/screens/fazer_reserva_screen.dart';
import 'package:hoptimum/screens/sem_reserva_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/seguranca.dart';
import '../models/despesa.dart';
import '../screens/category_meals_screen.dart';
import '../screens/func_solicitacao_screen.dart';
import '../screens/func_seguranca_screen.dart';
import '../screens/home_screen.dart';
import '../screens/info_screen.dart';
import '../screens/login_screen.dart';
import '../screens/reserva_info.dart';
import '../screens/tabs_screen.dart';
import '../screens/tela_reserva.dart';
import '../screens/categories_screen.dart';
import '../models/providers/auth.dart';
import '../screens/func_limpeza_screen.dart';
import '../screens/info_hospede_screen.dart';
import '../globals.dart' as globals;

void main() {
  Intl.defaultLocale = 'pt_BR';
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const HoptimumApp());
}

class HoptimumApp extends StatefulWidget {
  const HoptimumApp({Key? key}) : super(key: key);

  @override
  State<HoptimumApp> createState() => _HoptimumAppState();
}

Future<void> reLogin() async {
  final url = Uri.parse(globals.getUrl('http', 'api/login'));
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(
      {
        'email': globals.email,
        'senha': globals.password,
        'id': globals.chave,
      },
    ),
  );
  // JsonEncoder encoder = JsonEncoder.withIndent('  ');
  // print(encoder.convert(json.decode(response.body)));
  globals.loginData = json.decode(response.body);
  final data = json.decode(response.body) as Map;
  //print(data);

  if (data.containsKey('hospede')) {
    getLog();
    getDepesaLog();
    getPedidosHosp();
  }
  if (data.containsKey('funcionario')) {
    getLogFunc();
    if (data['funcionario']['cargo']['nome'] == 'cozinha') {
      getPedidos();
    }
    if (data['funcionario']['cargo']['nome'] == 'limpeza') {
      getServicos();
    }
    if (data['funcionario']['cargo']['nome'] == 'seguranca') {
      //TODO:provavelmnte o get da lista de hospedes vai aqui
    }
  }
}

//TODO:CONFERIR SE TEM RESERVA EM ['hospede']['reservas']
class _HoptimumAppState extends State<HoptimumApp> {
  void _connect() async {
    globals.channel = IOWebSocketChannel.connect(globals.getUrl('ws', ''));
    print('💩💩💩💩💩💩💩💩💩💩💩💩💩');
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');

    try {
      final url = Uri.parse(globals.getUrl('http', 'api/servicos'));
      final response = await http.get(url);
      globals.servicoList = json.decode(response.body);
    } catch (error) {
      print(error);
    }

    try {
      final url = Uri.parse(globals.getUrl('http', 'api/quartos'));
      final response = await http.get(url);
      globals.quartosList = json.decode(response.body);
    } catch (error) {
      print(error);
    }

    globals.channel?.stream.listen(
      (data) async {
        var res = json.decode(data) as Map;
        globals.listenData = data;

        print('🤪 conectou');

        //print(data);

        //print(jsonDecode(data)['createdAt'].toString());
        if (res['loginId'] != null) {
          globals.chave = res['loginId'];
          if (globals.email != null &&
              globals.password != null &&
              globals.email.toString().isNotEmpty &&
              globals.password.toString().isNotEmpty) {
            if (!globals.naoTenta) {
              print('ta relogando aqui em cima 💕');
              reLogin();
            }
          }
          if (globals.email == null && globals.password == null) {
            final prefs = await SharedPreferences.getInstance();
            if (!prefs.containsKey('userData')) {
              return;
            } else {
              final extractedUserData = json
                  .decode(prefs.getString('userData')!) as Map<String, dynamic>;
              globals.email = extractedUserData['email'] as String;
              globals.password = extractedUserData['password'] as String;

              if (!globals.naoTenta) {
                print('ta relogando aqui mais embaixo 🤣');
                reLogin();
              }
            }
          }
          //globals.loginData = res;
          //globals.chaveBackUp = res['loginId'];
          //print(res['loginId']);
          //res['loginId'] = '';

        }

        if (res.containsKey('funcionario') && res.containsKey('status')) {
          globals.newStatus = res;
          setState(() {
            updateStatus();
          });
          print('😱 update de log 😱');
          print('🥸🥸🥸 $res');
        } else if (res.containsKey('reserva')) {
          setState(() {
            addLog(res);
          });
          print('🧄 log de hospede 🧄');
          //print(encoder.convert(json.decode(data)));
        } else if (res.containsKey('funcionario')) {
          setState(() {
            addLog(res);
          });
          //print(encoder.convert(json.decode(data)));
          print('🤢 log de funcionario 🤢');
          //print(res['quarto']);
        } else if (res.containsKey('status')) {
          setState(() {
            addLog(res);
          });
          print('👌 log de carro 👌');
        }
        //print(encoder.convert(json.decode(data)));

        // globals.listenData = data;
        // DateTime teste = DateTime.parse(
        //     jsonDecode(globals.listenData)['createdAt'].toString());
        // print(teste);
      },
      onError: (error) => {/*print(error)*/},
      onDone: _connect,
    );
  }

  @override
  void initState() {
    super.initState();
    try {
      _connect();
    } catch (e) {
      print("🧄 ERRO AO CONECTAR NO WEBSOCKET: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'H\'Optimum',
          theme: ThemeData(
            fontFamily: 'Quicksand',
            textTheme: const TextTheme(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xffF75E3B),
              secondary: const Color.fromARGB(255, 49, 50, 61),
            ),
          ),
          home: auth.isAuth
              ? globals.perfil == 'hospede'
                  ? const TabsScreen()
                  : globals.perfil == 'hospede-sem-reserva'
                      ? const SemReservaScreen()
                      : globals.perfil == 'limpeza'
                          ? const FuncLimpezaScreen()
                          : globals.perfil == 'cozinha'
                              ? const FuncSolicitacaoScreen()
                              : globals.perfil == 'seguranca'
                                  ? const FuncSegurancaScreen()
                                  : null
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Scaffold(
                              body: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const LoginScreen(),
                ),
          routes: {
            //'/': (context) => LoginScreen(),
            CategoriesScreen.routeName: (ctx) => const CategoriesScreen(),
            CategoryMealsScreen.routeName: (ctx) => const CategoryMealsScreen(),
            InfoScreen.routeName: (ctx) => const InfoScreen(),
            TabsScreen.routeName: (ctx) => const TabsScreen(),
            LoginScreen.routeName: (ctx) => const LoginScreen(),
            FuncSolicitacaoScreen.routeName: (ctx) =>
                const FuncSolicitacaoScreen(),
            FuncSegurancaScreen.routeName: (ctx) => const FuncSegurancaScreen(),
            TelaReserva.routeName: (ctx) => const TelaReserva(),
            ReservaInfo.routeName: (ctx) => const ReservaInfo(),
            FuncLimpezaScreen.routeName: (ctx) => const FuncLimpezaScreen(),
            InfoHospedeScreen.routeName: (ctx) => const InfoHospedeScreen(),
            CadastroScreen.routeName: (ctx) => const CadastroScreen(),
            SemReservaScreen.routeName: (ctx) => const SemReservaScreen(),
            CadastroCarroScreen.routeName: (ctx) => const CadastroCarroScreen(),
            CadastroDependenteScreen.routeName: (ctx) =>
                const CadastroDependenteScreen(),
            FazerReservaScreen.routeName: (ctx) => const FazerReservaScreen(),
          },
          onGenerateRoute: (settings) {
            return MaterialPageRoute(builder: (context) => const HomePage());
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(builder: (context) => const HomePage());
          },
        ),
      ),
    );
  }
}

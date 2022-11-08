// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'models/hospede.dart';
import 'models/quarto.dart';
import 'models/seguranca.dart';
import 'screens/category_meals_screen.dart';
import 'screens/configuracoes_screen.dart';
import 'screens/funcSolicitacaoScreen.dart';
import 'screens/funcSegurancaScreen.dart';
import 'screens/home_screen.dart';
import 'screens/info_sceen.dart';
import 'screens/login_screen.dart';
import 'screens/reserva_info.dart';
import 'screens/tabs_screen.dart';
import 'screens/tela_reserva.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/categories_screen.dart';
import 'models/providers/auth.dart';
import 'globals.dart' as globals;

void main() {
  Intl.defaultLocale = 'pt_BR';
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(HoptimumApp());
}

class HoptimumApp extends StatefulWidget {
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

  if (data.containsKey('hospede')) {
    getLog();
  }
  if (data.containsKey('funcionario')) {}
}

class _HoptimumAppState extends State<HoptimumApp> {
  void _connect() {
    globals.channel = IOWebSocketChannel.connect(globals.getUrl('ws', ''));
    print('💩💩💩💩💩💩💩💩💩💩💩💩💩');
    JsonEncoder encoder = JsonEncoder.withIndent('  ');
    globals.channel?.stream.listen(
      (data) async {
        var res = json.decode(data) as Map;
        globals.listenData = data;

        //print(encoder.convert(json.decode(res)));

        //print(data);

        //print(jsonDecode(data)['createdAt'].toString());
        if (res['loginId'] != null) {
          globals.chave = res['loginId'];
          if (globals.email != null &&
              globals.password != null &&
              !globals.email.toString().isEmpty &&
              !globals.password.toString().isEmpty) {
            reLogin();
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
              reLogin();
            }
          }
          //globals.loginData = res;
          //globals.chaveBackUp = res['loginId'];
          print(res['loginId']);
          //res['loginId'] = '';
        }
        if (res.containsKey('reserva')) {
          setState(() {
            addLog(res);
          });

          // if (res.containsKey('reserva')) {
          //   var newData = Seguranca(
          //     id: 's1',
          //     title: 'Acesso ao quarto',
          //     info: 'Hóspede',
          //     //date: DateTime.now().toIso8601String(),
          //     date: res['createdAt'],
          //     tag: 'tag',
          //   );
          //   setState(
          //     () {
          //       SEGURANCA_DATA.insert(0, newData);
          //     },
          //   );
          // }
          // if (res.containsKey('funcionario')) {
          //   var newData = Seguranca(
          //     id: 's1',
          //     title: 'Acesso ao quarto',
          //     info: 'Funcionário',
          //     //date: DateTime.now().toIso8601String(),
          //     date: res['createdAt'],
          //     tag: 'tag',
          //   );
          //   setState(
          //     () {
          //       SEGURANCA_DATA.insert(0, newData);
          //     },
          //   );
          // }
          //data
          //globals.listenData = data;
          //var decodedData = jsonDecode(globals.listenData);
          //print(res);
          //print(res['hospede']['reservas']['reserva']['hospedes']);
          print(encoder.convert(json.decode(data)));
        }

        if (res.containsKey('status')) {
          setState(() {
            addLog(res);
          });
        }

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
            textTheme: TextTheme(
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
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color(0xffF75E3B),
              secondary: Color.fromARGB(255, 49, 50, 61),
            ),
          ),
          home: auth.isAuth
              ? globals.perfil == 'hospede'
                  ? TabsScreen()
                  : globals.perfil == 'limpeza'
                      ? FuncSolicitacaoScreen()
                      : globals.perfil == 'cozinha'
                          ? FuncSolicitacaoScreen()
                          : globals.perfil == 'seguranca'
                              ? FuncSegurancaScreen()
                              : null
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? Scaffold(
                              body: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : LoginScreen(),
                ),
          routes: {
            //'/': (context) => LoginScreen(),
            CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
            CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
            MealDetailScreen1.routeName: (ctx) => MealDetailScreen1(),
            InfoScreen.routeName: (ctx) => InfoScreen(),
            TabsScreen.routeName: (ctx) => TabsScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            ConfiguracoesScreen.routeName: (ctx) => ConfiguracoesScreen(),
            FuncSolicitacaoScreen.routeName: (ctx) => FuncSolicitacaoScreen(),
            FuncSegurancaScreen.routeName: (ctx) => FuncSegurancaScreen(),
            TelaReserva.routeName: (ctx) => TelaReserva(),
            ReservaInfo.routeName: (ctx) =>
                ReservaInfo(reserva: HOSPEDES[2].reserva, quarto: QUARTOS[3]),
          },
          onGenerateRoute: (settings) {
            return MaterialPageRoute(builder: (context) => HomePage());
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(builder: (context) => HomePage());
          },
        ),
      ),
    );
  }
}

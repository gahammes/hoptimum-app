import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../globals.dart' as globals;

class FazerReservaScreen extends StatelessWidget {
  static const routeName = '/fazer-reserva-screen';

  const FazerReservaScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 248, 141, 117),
                      Color.fromARGB(255, 248, 128, 101),
                      Color.fromARGB(255, 246, 106, 75),
                      Color(0xffF75E3B),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                    bottom: 80.0,
                    top: 0.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Authenticate(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  final Map<String, String> _dataMap = {
    'checkIn': '',
    'checkOut': '',
    'quarto': '',
  };
  final Map<String, String> _depMap = {
    'cpf': '',
  };
  var _isLoading = false;
  var _dataDisponivel = false;
  var _addDep = false;
  List<Map> listDep = [];
  Map<String, dynamic> mapReserva = {
    'checkIn': '',
    'checkOut': '',
    'quarto': '',
    'dependentes': [],
    'titular': '',
  };

  void _showErrorDiaglog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                _isLoading = false;
              });
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  void dataCheck() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final url = Uri.parse(globals.getUrl('http', 'api/reservacheck'));
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'checkIn': DateTime.parse(_dataMap['checkIn'].toString())
                .toIso8601String(),
            'checkOut': DateTime.parse(_dataMap['checkOut'].toString())
                .toIso8601String(),
            'quarto': _dataMap['quarto'].toString(),
          },
        ),
      );
      var res = json.decode(response.body) as Map;
      var infos = {};
      if (res.containsKey('error')) {
        print('😶‍🌫️ Data invalida');
        setState(() {
          _dataDisponivel = false;
        });
      } else {
        print('🥸 data disponivel');
        infos = res;
        mapReserva['checkIn'] =
            DateTime.parse(_dataMap['checkIn'].toString()).toIso8601String();
        mapReserva['checkOut'] =
            DateTime.parse(_dataMap['checkOut'].toString()).toIso8601String();
        mapReserva['quarto'] = _dataMap['quarto'].toString();
        setState(() {
          _dataDisponivel = true;
        });
      }
      //print('😶‍🌫️ $res');
      //globals.carrosArray.add(res['_id']);
    } catch (error) {
      print(error);
    }

    setState(() {
      _isLoading = false;
    });
    //Navigator.pop(context);
  }

  void depCheck() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final url = Uri.parse(globals.getUrl('http', 'api/hospedecheck'));
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'cpf': _depMap['cpf'],
          },
        ),
      );
      var res = json.decode(response.body) as Map;
      var infos = {};
      var taDentro = false;
      if (res.containsKey('error')) {
        print('😶‍🌫️ ${infos['error']}');
      } else {
        print('🥸 pessoa encontrada');
        infos = res;
        for (var i = 0; i < listDep.length; i++) {
          if (listDep[i]['_id'] == res['_id']) {
            taDentro = true;
          }
        }
        if (!taDentro) {
          listDep.add(infos);
        }
        taDentro = false;
        mapReserva['dependentes'] = listDep;
        print(listDep);
      }
      //print('😶‍🌫️ $res');
      //globals.carrosArray.add(res['_id']);
    } catch (error) {
      print(error);
    }

    setState(() {
      _isLoading = false;
    });
    //Navigator.pop(context);
  }

  void addReserva() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final url = Uri.parse(globals.getUrl('http', 'api/reserva'));
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'checkIn': mapReserva['checkIn'],
            'checkOut': mapReserva['checkOut'],
            'quarto': mapReserva['quarto'],
            'dependentes': mapReserva['dependentes'],
            'titular': globals.loginData['hospede']['_id'],
          },
        ),
      );
      var res = json.decode(response.body) as Map;
      print('😶‍🌫️ $res');
      //globals.carrosArray.add(res['_id']);
    } catch (error) {
      print(error);
    }

    setState(() {
      _isLoading = false;
    });
    //Navigator.pop(context);
  }

  final kLabelStyle = const TextStyle(
    color: Colors.white,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
  );

  final kBoxDecorationStyle = BoxDecoration(
    color: const Color.fromARGB(255, 255, 129, 101),
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  final kHintTextStyle = const TextStyle(
    color: Colors.white54,
    fontFamily: 'OpenSans',
  );

  Widget _buildCheckInTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Check-in', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            //onSubmitted: (_) => _loginDirection(),
            keyboardType: TextInputType.name,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            //decoration: InputDecoration(labelText: 'email'),
            onSaved: (value) {
              _dataMap['checkIn'] = value!;
            },

            //controller: emailController,

            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
              hintText: 'Digite a data de check-in',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckOutTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Check-out', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            //onSubmitted: (_) => _loginDirection(),
            //keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            //decoration: InputDecoration(labelText: 'email'),
            onSaved: (value) {
              _dataMap['checkOut'] = value!;
            },

            //controller: emailController,

            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
              hintText: 'Digite a data de check-out',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDependenteTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dependente', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            //onSubmitted: (_) => _loginDirection(),
            //keyboardType: TextInputType.,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            //decoration: InputDecoration(labelText: 'email'),
            // validator: (value) {
            //   if (value!.isEmpty || !value.contains('@')) {
            //     return 'Email invalido';
            //   }
            //   return null;
            // },
            onSaved: (value) {
              _depMap['cpf'] = value!;
            },

            //controller: emailController,

            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.king_bed,
                color: Colors.white,
              ),
              hintText: 'Digite o cpf do dependente',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCadastrarButton(bool isLoading, String text, VoidCallback func) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        //TODO:pegar os dados aqui
        onPressed: func,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Text(
                text,
                style: const TextStyle(
                  color: Color.fromARGB(255, 246, 106, 75),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          elevation: MaterialStateProperty.all(5.0),
          padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
    );
  }

  Widget _buildAddDepButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        //TODO:pegar os dados aqui
        onPressed: () {
          setState(() {
            _addDep = !_addDep;
          });
        },
        child: Text(
          _addDep ? 'Cancelar' : 'Adicionar dependente',
          style: const TextStyle(
            color: Color.fromARGB(255, 246, 106, 75),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          elevation: MaterialStateProperty.all(5.0),
          padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
    );
  }

  Widget _buildAddDependente() {
    return Column(
      children: [
        _buildDependenteTF(),
        _buildCadastrarButton(_isLoading, 'Checar dependente', depCheck),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _dataMap['quarto'] = routeArgs['id']!;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 60.0),
          const Text(
            'DATAS',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30.0),
          _buildCheckInTF(),
          const SizedBox(height: 30.0),
          _buildCheckOutTF(),
          const SizedBox(height: 30.0),
          _buildCadastrarButton(_isLoading, 'Checar datas', dataCheck),
          //const SizedBox(height: 30.0),
          if (_dataDisponivel) _buildAddDepButton(),
          //const SizedBox(height: 30.0),
          if (_dataDisponivel && _addDep) _buildAddDependente(),
          if (_dataDisponivel)
            _buildCadastrarButton(_isLoading, 'Fazer Reserva', addReserva),
        ],
      ),
    );
  }
}

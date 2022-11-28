import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hoptimum/models/providers/auth.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  final depController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  TextEditingController dateCheckInController = TextEditingController();
  TextEditingController dateCheckOutController = TextEditingController();
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime(DateTime.now().year + 20),
  );

  @override
  void initState() {
    dateCheckInController.text = '';
    dateCheckOutController.text = '';
    depController.text = '';
    super.initState();
  }

  final Map<String, String> _dataMap = {
    'checkIn': '',
    'checkOut': '',
    'quarto': '',
  };
  final Map<String, String> _depMap = {
    'cpf': '',
  };
  var _isLoading = false;
  var _isLoadingData = false;
  var _isLoadingDep = false;
  var _dataDisponivel = false;
  var _adicionarDep = false;
  var _confirmarReserva = false;
  var _addDep = false;
  var _depNome = '';
  int pessoaCount = 1;
  List<Map> listDep = [];
  Map<String, dynamic> mapReserva = {
    'checkIn': '',
    'checkOut': '',
    'quarto': '',
    'dependentes': [],
    'titular': '',
  };

  Future pickDateRange() async {
    setState(() {
      _dataDisponivel = false;
    });
    DateTimeRange? newDateRange = await showDateRangePicker(
      locale: Locale('pt', 'BR'),
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 20),
    );

    if (newDateRange == null) {
      return;
    }

    setState(() {
      dateRange = newDateRange;
      dateCheckInController.text =
          DateFormat('dd/MM/yyyy').format(dateRange.start);
      dateCheckOutController.text =
          DateFormat('dd/MM/yyyy').format(dateRange.end);
    });
  }

  Widget fecharButton(BuildContext ctx) {
    return TextButton(
      child: const Text("Fechar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget cancelarButton(BuildContext ctx) {
    return TextButton(
      child: const Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget removerButton(BuildContext ctx) {
    return TextButton(
      child: const Text("Remover"),
      onPressed: () {
        setState(() {
          _addDep = false;
          pessoaCount--;
          listDep.removeWhere((dep) => dep['nome'] == _depNome);
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget adicionarButton(BuildContext ctx) {
    return TextButton(
      child: const Text("Adicionar"),
      onPressed: () {
        setState(() {
          _adicionarDep = true;
          depController.text = '';
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget confirmarReservaButton(BuildContext ctx) {
    return TextButton(
      child: const Text("Confirmar"),
      onPressed: () {
        setState(() {
          _confirmarReserva = true;
        });
        Navigator.of(context).pop();
      },
    );
  }

  AlertDialog depAlertDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Dependente não encontrado!",
        style: TextStyle(color: Colors.black),
      ),
      //contentTextStyle: TextStyle(),
      content: const Text(
        "Por favor, verifique o CPF ou cadastre o dependente na tela de cadastro.",
      ),
      actions: [
        fecharButton(context),
      ],
    );
  }

  AlertDialog depRepetidoDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Dependente já adicionado!",
        style: TextStyle(color: Colors.black),
      ),
      //contentTextStyle: TextStyle(),
      content: const Text(
        "Dependente já está incluso na reserva.",
      ),
      actions: [
        fecharButton(context),
      ],
    );
  }

  AlertDialog cpfTitularDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "CPF do titular!",
        style: TextStyle(color: Colors.black),
      ),
      //contentTextStyle: TextStyle(),
      content: const Text(
        "Por favor, insira outro CPF.",
      ),
      actions: [
        fecharButton(context),
      ],
    );
  }

  AlertDialog dataAlertDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Datas não disponíveis!",
        style: TextStyle(color: Colors.black),
      ),
      //contentTextStyle: TextStyle(),
      content: const Text(
        "Por favor, selecione outro intervalo de datas.",
      ),
      actions: [
        fecharButton(context),
      ],
    );
  }

  AlertDialog removerDepDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Remover dependente?",
        style: TextStyle(color: Colors.black),
      ),
      //contentTextStyle: TextStyle(),
      content: const Text(
        "Clique em remover para retirar o dependente da reserva.",
      ),
      actions: [
        cancelarButton(context),
        removerButton(context),
      ],
    );
  }

  AlertDialog confirmarReservaDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Confirme sua reserva!",
        style: TextStyle(color: Colors.black),
      ),
      //contentTextStyle: TextStyle(),
      content: const Text(
        "Clique em confirmar para prosseguir com a reserva.",
      ),
      actions: [
        cancelarButton(context),
        confirmarReservaButton(context),
      ],
    );
  }

  AlertDialog adicionarDepDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Adicionar dependente?",
        style: TextStyle(color: Colors.black),
      ),
      //contentTextStyle: TextStyle(),
      content: const Text(
        "Clique em adicionar para incluir o dependente na reserva.",
      ),
      actions: [
        cancelarButton(context),
        adicionarButton(context),
      ],
    );
  }

  void dataCheck() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoadingData = true;
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
        showDialog(context: context, builder: dataAlertDialog);
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
      _isLoadingData = false;
    });
    //Navigator.pop(context);
  }

  void depCheck() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    setState(() {
      _isLoadingDep = true;
    });
    if (_depMap['cpf'] == globals.loginData['hospede']['cpf']) {
      await showDialog(context: context, builder: cpfTitularDialog);
      setState(() {
        _isLoadingDep = false;
      });
      return;
    }
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
        showDialog(context: context, builder: depAlertDialog);
        print('😶‍🌫️ ${res['error']}');
      } else {
        print('🥸 pessoa encontrada');
        infos = res;
        for (var i = 0; i < listDep.length; i++) {
          if (listDep[i]['_id'] == res['_id']) {
            taDentro = true;
          }
        }
        if (!taDentro) {
          await showDialog(context: context, builder: adicionarDepDialog);
          if (_adicionarDep) {
            setState(() {
              listDep.add(infos);
              pessoaCount++;
            });
            print('ADICIONOU AGORA! 🤖');
          }
        } else {
          showDialog(context: context, builder: depRepetidoDialog);
        }
        _adicionarDep = false;
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
      _isLoadingDep = false;
    });
    //Navigator.pop(context);
  }

  void _logout() {
    Provider.of<Auth>(context, listen: false).logout();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    //Navigator.of(context).pushReplacementNamed('/');
  }

  void addReserva() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    await showDialog(context: context, builder: confirmarReservaDialog);
    if (!_confirmarReserva) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
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
    _logout();
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

  Widget _builCheckInPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Data inicial', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: dateCheckInController,
            onSaved: (value) {
              _dataMap['checkIn'] = dateRange.start.toIso8601String();
            },
            onTap: pickDateRange,
            readOnly: true,
            keyboardType: TextInputType.datetime,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
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
              hintText: 'Selecione a data incial',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _builCheckOutPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Data de término', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: dateCheckOutController,
            onTap: pickDateRange,
            onSaved: (value) {
              _dataMap['checkOut'] = dateRange.end.toIso8601String();
            },
            readOnly: true,
            keyboardType: TextInputType.datetime,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
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
              hintText: 'Selecione a data de término',
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
            controller: depController,
            //onSubmitted: (_) => _loginDirection(),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                Icons.person_add,
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

  Widget _buildDependentes(String nome, int i) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (i == 0) Text('Dependentes adicionados', style: kLabelStyle),
            if (i == 0) const SizedBox(height: 10.0),
            if (i != 0) const SizedBox(height: 15.0),
            Container(
              alignment: Alignment.center,
              decoration: kBoxDecorationStyle,
              width: 260.0,
              height: 60.0,
              child: TextFormField(
                readOnly: true,
                enabled: false,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  labelText: nome,
                  border: InputBorder.none,
                  //label: Text(nome),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  ),
                  contentPadding: const EdgeInsets.only(top: 14.0),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  //hintText: 'Digite o cpf do dependente',
                  hintStyle: kHintTextStyle,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 7.0),
          child: IconButton(
            onPressed: () {
              setState(() {
                _depNome = nome;
              });
              showDialog(
                context: context,
                builder: removerDepDialog,
              );
              print('deleta');
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerificarDatasButton(bool isLoading, VoidCallback func) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _dataDisponivel ? null : func,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Text(
                _dataDisponivel ? 'Datas disponíveis' : 'Verificar datas',
                style: TextStyle(
                  color: _dataDisponivel
                      ? Colors.white
                      : Color.fromARGB(255, 246, 106, 75),
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
          backgroundColor: MaterialStateProperty.all(
              _dataDisponivel ? Colors.green : Colors.white),
        ),
      ),
    );
  }

  Widget _buildCheckDepButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: depCheck,
        child: _isLoadingDep
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const Text(
                'Verificar dependente',
                style: TextStyle(
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

  Widget _buildFazerReservaButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: addReserva,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Text(
                'Fazer reserva'.toUpperCase(),
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
        _buildCheckDepButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _dataMap['quarto'] = routeArgs['id']!;
    var maxOcupantes = int.parse(routeArgs['maxOcupantes']!);
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
          _builCheckInPicker(),
          const SizedBox(height: 30.0),
          _builCheckOutPicker(),
          const SizedBox(height: 10.0),
          _buildVerificarDatasButton(_isLoadingData, dataCheck),
          //const SizedBox(height: 30.0),

          if (_dataDisponivel && pessoaCount < maxOcupantes)
            _buildAddDepButton(),
          //const SizedBox(height: 30.0),

          if (_dataDisponivel && _addDep && pessoaCount < maxOcupantes)
            _buildAddDependente(),
          if (_dataDisponivel && listDep.isNotEmpty)
            for (var i = 0; i < listDep.length; i++)
              _buildDependentes(listDep[i]['nome'].toString(), i),
          if (_dataDisponivel) _buildFazerReservaButton(),
        ],
      ),
    );
  }
}

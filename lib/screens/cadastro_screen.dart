import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hoptimum/screens/cadastro_carro_screen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../globals.dart' as globals;
import '../models/http_exception.dart';
import '../models/providers/auth.dart';

enum AuthMode { hospede, funcionario }

class CadastroScreen extends StatelessWidget {
  static const routeName = '/cadastro-screen';

  const CadastroScreen({Key? key}) : super(key: key);
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
              // Container(
              //   margin: const EdgeInsets.only(top: 50),
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 10.0,
              //     vertical: 10.0,
              //   ),
              //   height: 200,
              //   child: const Image(
              //     image: AssetImage('assets/images/logo-black.png'),
              //   ),
              // ),
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
                      // Text(
                      //   'Entrar',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 30.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
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
  TextEditingController dateInput = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _cpfFocusNode = FocusNode();
  final _dataFocusNode = FocusNode();
  final _generoFocusNode = FocusNode();
  final _telefoneFocusNode = FocusNode();
  String _cargoResult = '';
  String _cargo = '';
  DateTime? pickedDate;
  List<String> validacoes = [];

  AuthMode? _authMode = AuthMode.hospede;
  final Map<String, String> _authData = {
    'email': '',
    'senha': '',
    'nome': '',
    'nascimento': '',
    'genero': '',
    'telefone': '',
    'cpf': '',
    'tipo': '',
    'cargo': '',
  };
  Map<String, String> validationHospData = {
    'email': '',
    'senha': '',
    'nome': '',
    'telefone': '',
    'cpf': '',
  };

  var _isLoading = false;

  @override
  void initState() {
    dateInput.text = '';
    super.initState();
  }

  Widget fecharButton(BuildContext ctx) {
    return TextButton(
      child: const Text("Fechar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget confirmarButton(BuildContext ctx) {
    return TextButton(
      child: const Text("Confirmar"),
      onPressed: () {
        Navigator.of(context).pop();
        tryCadastro();
      },
    );
  }

  AlertDialog validacoesDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "ERRO!",
        style: TextStyle(color: Colors.black),
      ),
      //contentTextStyle: TextStyle(),
      content: Container(
        height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top) *
            0.22,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [for (var validacao in validacoes) Text(validacao)],
        ),
      ),
      actions: [
        fecharButton(context),
      ],
    );
  }

  AlertDialog confirmarDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Confirme o cadastro!",
        style: TextStyle(color: Colors.black),
      ),
      //contentTextStyle: TextStyle(),
      content: Container(
        height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top) *
            0.13,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Lembre-se de adcionar um carro caso seja necessário.'),
            Text('Clique em confirmar para prosseguir com o cadastro.'),
          ],
        ),
      ),
      actions: [
        fecharButton(context),
        confirmarButton(context),
      ],
    );
  }

  void tryCadastro() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
      _cargoResult = _cargo;
    });

    if (_authData['nome'] != null) {
      //VALIDACAO DO NOME
      if (_authData['nome']!.isEmpty) {
        setState(() {
          _isLoading = false;
          validationHospData['nome'] = 'vazio';
          validacoes.add('Preencha o campo Nome.');
          //count++;
        });
        // print('preencha todos os campos');
        // return;
      } else if (!RegExp("^[A-Za-z ,.'-]+\$").hasMatch(_authData['nome']!)) {
        setState(() {
          _isLoading = false;
          validationHospData['nome'] = 'regex';
          validacoes.add('Insira um nome válido (apenas letras).');
          //count++;
        });
        // print('coloca um nome decente');
        // return;
      }
    } else {
      setState(() {
        _isLoading = false;
        validationHospData['nome'] = 'vazio';
        validacoes.add('Preencha o campo Nome.');
        // count++;
      });
      // print('preencha todos os campos');
      // return;
    }

    if (_authData['email'] != null) {
      //VALIDACAO DO EMAIL
      if (_authData['email']!.isEmpty) {
        setState(() {
          _isLoading = false;
          validationHospData['email'] = 'vazio';
          validacoes.add('Preencha o campo Email.');
          // count++;
        });
        // print('preencha todos os campos');
        // return;
      } else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_authData['email']!)) {
        setState(() {
          _isLoading = false;
          validationHospData['email'] = 'regex';
          validacoes.add('Insira um email válido.');
          // count++;
        });
        // print('coloca um email decente');
        // return;
      }
    } else {
      setState(() {
        _isLoading = false;
        validationHospData['email'] = 'vazio';
        validacoes.add('Preencha o campo Email.');
        // count++;
      });
      // print('preencha todos os campos');
      // return;
    }

    if (_authData['cpf'] != null) {
      //VALIDACAO DO CPF
      if (_authData['cpf']!.isEmpty) {
        setState(() {
          _isLoading = false;
          validationHospData['cpf'] = 'vazio';
          validacoes.add('Preencha o campo CPF.');
          // count++;
        });
        // print('preencha todos os campos');
        // return;
      } else if (!RegExp("^(?:[+0]9)?[0-9]{11}\$")
          .hasMatch(_authData['cpf']!)) {
        setState(() {
          _isLoading = false;
          validationHospData['cpf'] = 'regex';
          validacoes.add('Insira um CPF válido (apenas números).');
          // count++;
        });
        // print('coloca um cpf decente');
        // return;
      }
    } else {
      setState(() {
        _isLoading = false;
        validationHospData['cpf'] = 'vazio';
        validacoes.add('Preencha o campo CPF.');
        // count++;
      });
      // print('preencha todos os campos');
      // return;
    }

    if (_authData['telefone'] != null) {
      //VALIDACAO DO TELEFONE
      if (_authData['telefone']!.isEmpty) {
        setState(() {
          _isLoading = false;
          validationHospData['telefone'] = 'vazio';
          validacoes.add('Preencha o campo Telefone.');
          // count++;
        });
        // print('preencha todos os campos');
        // return;
      } else if (!RegExp(r"^(?:[+0]9)?[0-9]{11}$")
          .hasMatch(_authData['telefone']!)) {
        setState(() {
          _isLoading = false;
          validationHospData['telefone'] = 'regex';
          validacoes.add(
              'Insira um telefone válido (apenas números, incluindo o DDD).');
          // count++;
        });
        // print('coloca um telefone decente');
        // return;
      }
    } else {
      setState(() {
        _isLoading = false;
        validationHospData['telefone'] = 'vazio';
        validacoes.add('Preencha o campo Telefone.');
        // count++;
      });
      // print('preencha todos os campos');
      // return;
    }

    if (_authData['senha'] != null) {
      //VALIDACAO DA SENHA
      if (_authData['senha']!.isEmpty) {
        setState(() {
          _isLoading = false;
          validationHospData['senha'] = 'vazio';
          validacoes.add('Preencha o campo Senha.');
          // count++;
        });
        // print('preencha todos os campos');
        // return;
      } else if (_authData['senha']!.length < 5) {
        setState(() {
          _isLoading = false;
          validationHospData['senha'] = 'regex';
          validacoes.add('A senha deve ter no mínimo 5 caractéres.');
          // count++;
        });
        // print('coloca uma senha decente');
        // return;
      }
    } else {
      setState(() {
        _isLoading = false;
        validationHospData['senha'] = 'vazio';
        validacoes.add('Preencha o campo Senha.');
        // count++;
      });
      // print('preencha todos os campos');
      // return;
    }

    if (validacoes.isNotEmpty) {
      await showDialog(context: context, builder: validacoesDialog);

      validacoes = [];
      validacoes.clear();
      return;
    }

    try {
      final url = Uri.parse(globals.getUrl('http', 'api/cadastro'));
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'email': _authData['email'].toString(),
            'senha': _authData['senha'].toString(),
            'nome': _authData['nome'].toString(),
            'nascimento': _authData['nascimento'].toString(),
            'genero': _authData['genero'].toString(),
            'telefone': _authData['telefone'].toString(),
            'cpf': _authData['cpf'].toString(),
            'tipo': _authMode == AuthMode.hospede ? 'hospede' : 'funcionario',
            'cargo': _authData['cargo'].toString(),
            'carros': globals.carrosArray,
          },
        ),
      );
      print('😶‍🌫️ ${json.decode(response.body)}');
      globals.carrosArray.clear();
      globals.carrosArray = [];
    } catch (error) {
      print(error);
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  Widget _switchAuthMode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 108, 74),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              setState(() {
                _authMode = AuthMode.hospede;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Hóspede'.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 108, 74),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              setState(() {
                _authMode = AuthMode.funcionario;
              });
            },
            child: Text(
              'Funcionário'.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
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

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            focusNode: _emailFocusNode,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_cpfFocusNode);
            },
            onSaved: (value) {
              _authData['email'] = value!;
            },
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Digite seu email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNomeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nome', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.name,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_emailFocusNode);
            },
            onSaved: (value) {
              _authData['nome'] = value!;
            },
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Digite seu nome',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _builDataPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Data de Nascimento', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            focusNode: _dataFocusNode,
            controller: dateInput,
            onTap: () async {
              pickedDate = await showDatePicker(
                locale: const Locale('pt', 'BR'),
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                //print(pickedDate);
                String formattedDate =
                    DateFormat('dd/MM/yyyy').format(pickedDate!);
                //print(formattedDate);
                setState(() {
                  dateInput.text = formattedDate;
                });
              }
            },
            readOnly: true,
            keyboardType: TextInputType.datetime,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_generoFocusNode);
            },
            onSaved: (value) {
              try {
                _authData['nascimento'] = pickedDate!.toIso8601String();
              } catch (_) {
                setState(() {
                  validacoes.add('Selecione uma data de nascimento.');
                });
              }
            },
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
              hintText: 'Selecione a data de nascimento',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTelefoneTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Telefone', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            focusNode: _telefoneFocusNode,
            keyboardType: TextInputType.phone,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            onSaved: (value) {
              _authData['telefone'] = value!;
            },
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.phone,
                color: Colors.white,
              ),
              hintText: 'Digite seu telefone',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCargoDropDown() {
    const List<String> list = <String>['Segurança', 'Cozinha', 'Limpeza'];
    String? _selectedValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cargo', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: DropdownButtonFormField(
            dropdownColor: const Color.fromARGB(255, 254, 73, 32),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.cases_outlined,
                color: Colors.white,
              ),
              hintStyle: TextStyle(color: Colors.blue),
            ),
            value: _selectedValue,
            hint: Text(
              'Selecione seu cargo',
              style: kHintTextStyle,
            ),
            isExpanded: true,
            onChanged: (String? value) {
              setState(() {
                _selectedValue = value!;
              });
            },
            onSaved: (String? value) {
              try {
                setState(() {
                  _selectedValue = value!;
                  if (value == 'Segurança') {
                    _authData['cargo'] = 'segurança';
                  } else if (value == 'Cozinha') {
                    _authData['cargo'] = 'cozinha';
                  } else {
                    _authData['cargo'] = 'limpeza';
                  }
                });
              } catch (_) {
                setState(() {
                  validacoes.add('Selecione um cargo.');
                });
              }
            },
            items: list.map((String val) {
              return DropdownMenuItem(
                value: val,
                child: Text(
                  val,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCPFTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CPF', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            focusNode: _cpfFocusNode,
            keyboardType: TextInputType.number,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_dataFocusNode);
            },
            onSaved: (value) {
              _authData['cpf'] = value!;
            },
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.numbers,
                color: Colors.white,
              ),
              hintText: 'Digite seu CPF',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Senha', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            onFieldSubmitted: (_) => tryCadastro,
            focusNode: _passwordFocusNode,
            onSaved: (value) {
              _authData['senha'] = value!;
            },
            cursorColor: Colors.white,
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Digite sua senha',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGeneroDropDown() {
    const List<String> list = <String>[
      'Homem',
      'Mulher',
      'Prefiro não informar'
    ];
    String? _selectedValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gênero', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: DropdownButtonFormField(
            focusNode: _generoFocusNode,
            dropdownColor: const Color.fromARGB(255, 254, 73, 32),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.cases_outlined,
                color: Colors.white,
              ),
              hintStyle: TextStyle(color: Colors.blue),
            ),
            value: _selectedValue,
            hint: Text(
              'Selecione seu gênero',
              style: kHintTextStyle,
            ),
            isExpanded: true,
            onChanged: (String? value) {
              setState(() {
                _selectedValue = value!;
              });
            },
            onSaved: (String? value) {
              try {
                setState(() {
                  _selectedValue = value!;
                  if (value == 'Homem') {
                    _authData['genero'] = 'M';
                  } else if (value == 'Mulher') {
                    _authData['genero'] = 'F';
                  } else {
                    _authData['genero'] = 'X';
                  }
                });
              } catch (error) {
                setState(() {
                  validacoes.add('Selecione um gênero.');
                });
              }
            },
            items: list.map((String val) {
              return DropdownMenuItem(
                value: val,
                child: Text(
                  val,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  List<Widget> camposCadastro() {
    return _authMode == AuthMode.hospede
        ? [
            const SizedBox(height: 30.0),
            const Text(
              'CADASTRO DE HÓSPEDE',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30.0),
            _buildSignUpButton(
                'Quer cadastrar um carro? ', CadastroCarroScreen.routeName),
            // const SizedBox(height: 10.0),
            // _buildSignUpButton('Quer cadastrar um dependente? ',
            //     CadastroDependenteScreen.routeName),
            const SizedBox(height: 30.0),
            _buildNomeTF(),
            const SizedBox(height: 30.0),
            _buildEmailTF(),
            const SizedBox(height: 30.0),
            _buildCPFTF(),
            const SizedBox(height: 30.0),
            _builDataPicker(),
            const SizedBox(height: 30.0),
            _buildGeneroDropDown(),
            const SizedBox(height: 30.0),
            _buildTelefoneTF(),
            const SizedBox(height: 30.0),
            _buildPasswordTF(),
            const SizedBox(height: 30.0),
            _buildCadastroButton(_isLoading),
          ]
        : [
            const SizedBox(height: 30.0),
            const Text(
              'CADASTRO DE FUNCIONÁRIO',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30.0),
            _buildSignUpButton(
                'Quer cadastrar um carro? ', CadastroCarroScreen.routeName),
            const SizedBox(height: 30.0),
            _buildNomeTF(),
            const SizedBox(height: 30.0),
            _buildEmailTF(),
            const SizedBox(height: 30.0),
            _buildCargoDropDown(),
            const SizedBox(height: 30.0),
            _buildCPFTF(),
            const SizedBox(height: 30.0),
            _builDataPicker(),
            const SizedBox(height: 30.0),
            _buildGeneroDropDown(),
            const SizedBox(height: 30.0),
            _buildTelefoneTF(),
            const SizedBox(height: 30.0),
            _buildPasswordTF(),
            const SizedBox(height: 30.0),
            _buildCadastroButton(_isLoading),
          ];
  }

  Widget _buildCadastroButton(bool isLoading) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await showDialog(context: context, builder: confirmarDialog);
        },
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const Text(
                'Cadastrar',
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

  Widget _buildSignUpButton(String text, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const TextSpan(
              text: 'Clique aqui',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 60.0),
          _switchAuthMode(),
          Column(
            children: camposCadastro(),
          )
        ],
      ),
    );
  }
}

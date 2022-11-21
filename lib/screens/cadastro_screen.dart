import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hoptimum/screens/cadastro_carro_screen.dart';
import 'package:hoptimum/screens/cadastro_dependente_screen.dart';
import 'package:http/http.dart' as http;
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
  final _passwordFocusNode = FocusNode();
  String _cargoResult = '';
  String _cargo = '';

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
  var _isLoading = false;
  final _passwordController = TextEditingController();

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

  void tryCadastro() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
      _cargoResult = _cargo;
    });
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
      print(json.decode('😶‍🌫️ ${response.body}'));
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      //TODO:CADASTRO
      await Provider.of<Auth>(context, listen: false).login(
        _authData['email']!,
        _authData['password']!,
      );
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed.';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email adress is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email adress.';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDiaglog(errorMessage);
    } catch (error) {
      const errorMessage = 'Something wrong happened. Try again.';
      print(error);
      _showErrorDiaglog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
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
            //onSubmitted: (_) => _loginDirection(),
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            //decoration: InputDecoration(labelText: 'email'),
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return 'Email invalido';
              }
              return null;
            },
            onSaved: (value) {
              _authData['email'] = value!;
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
            //onSubmitted: (_) => _loginDirection(),
            keyboardType: TextInputType.name,
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
              _authData['nome'] = value!;
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

  Widget _builDataTF() {
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
            //onSubmitted: (_) => _loginDirection(),
            keyboardType: TextInputType.datetime,
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
              _authData['nascimento'] = value!;
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
              hintText: 'Digite sua data de nascimento',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _builGeneroTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gênero', style: kLabelStyle),
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
            // validator: (value) {
            //   if (value!.isEmpty || !value.contains('@')) {
            //     return 'Email invalido';
            //   }
            //   return null;
            // },
            onSaved: (value) {
              _authData['genero'] = value!;
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
                Icons.face,
                color: Colors.white,
              ),
              hintText: 'Digite seu gênero',
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
            //onSubmitted: (_) => _loginDirection(),
            keyboardType: TextInputType.phone,
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
              _authData['telefone'] = value!;
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
            },
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Selecione uma opção';
              } else {
                return null;
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

  Widget _buildCargoTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cargo', style: kLabelStyle),
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
            // validator: (value) {
            //   if (value!.isEmpty || !value.contains('@')) {
            //     return 'Email invalido';
            //   }
            //   return null;
            // },
            onSaved: (value) {
              _authData['cargo'] = value!;
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
                Icons.cases_outlined,
                color: Colors.white,
              ),
              hintText: 'Digite seu cargo',
              hintStyle: kHintTextStyle,
            ),
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
            //onSubmitted: (_) => _loginDirection(),
            keyboardType: TextInputType.number,
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
              _authData['cpf'] = value!;
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
            validator: (value) {
              if (value!.isEmpty || value.length < 1) {
                return 'A senha é muito curta.';
              }
              return null;
            },
            onFieldSubmitted: (_) => _submit(),
            focusNode: _passwordFocusNode,
            onSaved: (value) {
              _authData['senha'] = value!;
            },
            controller: _passwordController,
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
        // if (_authMode == AuthMode.signup)
        //   TextFormField(
        //     enabled: _authMode == AuthMode.signup,
        //     decoration: const InputDecoration(labelText: 'Confirm Password'),
        //     obscureText: true,
        //     validator: _authMode == AuthMode.signup
        //         ? (value) {
        //             if (value != _passwordController.text) {
        //               return 'A senha n e a mesma';
        //             }
        //             return null;
        //           }
        //         : null,
        //   ),
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
              setState(() {
                _selectedValue = value!;
                if (value == 'Homem') {
                  _authData['genero'] = 'H';
                } else if (value == 'Mulher') {
                  _authData['genero'] = 'M';
                } else {
                  _authData['genero'] = 'X';
                }
              });
            },
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Selecione uma opção';
              } else {
                return null;
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
            _builDataTF(),
            const SizedBox(height: 30.0),
            _buildGeneroDropDown(),
            const SizedBox(height: 30.0),
            _buildTelefoneTF(),
            const SizedBox(height: 30.0),
            _buildPasswordTF(),
            const SizedBox(height: 30.0),
            _buildLoginButton(_isLoading),
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
            _buildNomeTF(),
            const SizedBox(height: 30.0),
            _buildEmailTF(),
            const SizedBox(height: 30.0),
            _buildCargoDropDown(),
            const SizedBox(height: 30.0),
            _buildCPFTF(),
            const SizedBox(height: 30.0),
            _builDataTF(),
            const SizedBox(height: 30.0),
            _buildGeneroDropDown(),
            const SizedBox(height: 30.0),
            _buildTelefoneTF(),
            const SizedBox(height: 30.0),
            _buildPasswordTF(),
            const SizedBox(height: 30.0),
            _buildLoginButton(_isLoading),
          ];
  }

  Widget _buildLoginButton(bool isLoading) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        //TODO:pegar os dados aqui
        onPressed: tryCadastro,
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

  Widget _radioChoice() {
    return Column(
      children: [
        RadioListTile<AuthMode>(
          title: const Text('Hóspede'),
          value: AuthMode.hospede,
          groupValue: _authMode,
          onChanged: (AuthMode? choice) {
            setState(() {
              _authMode = choice;
            });
          },
        ),
        RadioListTile<AuthMode>(
          title: const Text('Funcionário'),
          value: AuthMode.funcionario,
          groupValue: _authMode,
          onChanged: (AuthMode? choice) {
            setState(() {
              _authMode = choice;
            });
          },
        ),
      ],
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

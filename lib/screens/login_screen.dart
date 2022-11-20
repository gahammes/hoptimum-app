import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hoptimum/screens/cadastro_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../globals.dart' as globals;
import '../models/http_exception.dart';
import '../models/providers/auth.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screen';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                height: 200,
                child: const Image(
                  image: AssetImage('assets/images/logo-black.png'),
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
                    top: 200.0,
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
                        child: AuthPart(),
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

class AuthPart extends StatefulWidget {
  const AuthPart({Key? key}) : super(key: key);

  @override
  State<AuthPart> createState() => _AuthPartState();
}

class _AuthPartState extends State<AuthPart> {
  var _rememberMe = globals.rememberMe ?? false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
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
      const errorMessage = 'Algo deu errado.';
      print(error);
      _showErrorDiaglog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
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
              hintText: 'Digite seu Email',
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
              _authData['password'] = value!;
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
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print('FP Button Pressed'),
        child: Text(
          'Esqueci minha senha',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCB() {
    return SizedBox(
      height: 60.0,
      child: Row(
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                  globals.rememberMe = _rememberMe;
                });
              },
            ),
          ),
          Text(
            'Manter conectado',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton(bool isLoading) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        //TODO:pegar os dados aqui
        onPressed: _submit,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const Text(
                'Entrar',
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

  Widget _buildSignUpButton() {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     PageRouteBuilder(
        //       pageBuilder: (_, __, ___) => CadastroScreen(),
        //       transitionDuration: Duration(seconds: 4),
        //       transitionsBuilder: (_, a, __, c) =>
        //           FadeTransition(opacity: a, child: c),
        //     ));
        Navigator.of(context).pushNamed(CadastroScreen.routeName);
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Não possui uma conta? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Cadastre-se',
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
          const SizedBox(height: 30.0),
          _buildEmailTF(),
          const SizedBox(height: 30.0),
          _buildPasswordTF(),
          // _buildForgotPasswordBtn(),
          _buildRememberMeCB(),
          _buildLoginButton(_isLoading),
          _buildSignUpButton(),
        ],
      ),
    );
  }
}

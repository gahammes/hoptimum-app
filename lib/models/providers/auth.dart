import 'dart:convert';
import 'dart:async';
import 'package:dashboard_tcc/models/data/seguranca_data.dart';
import 'package:dashboard_tcc/models/seguranca.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart' as globals;

import '../http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;

  String? get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  bool get isAuth {
    return token != null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> _authenticate(String email, String password,
      String urlSegmentStart, String urlSegmentEnd) async {
    final url = Uri.parse(globals.getUrl(urlSegmentStart, urlSegmentEnd));
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'email': email,
            'senha': password,
            'id': globals.chave,
          },
        ),
      );
      globals.email = email;
      globals.password = password;
      var decodedRes = json.decode(response.body) as Map;
      if (decodedRes.containsKey('hospede')) {
        globals.perfil = 'hospede';
      }
      if (decodedRes.containsKey('funcionario')) {
        switch (decodedRes['funcionario']['cargo']['nome']
            .toString()
            .toLowerCase()) {
          case 'segurança':
            globals.perfil = 'seguranca';
            break;
          case 'limpeza':
            globals.perfil = 'limpeza';
            break;
          case 'cozinha':
            globals.perfil = 'cozinha';
            break;
        }
      }
      //JsonEncoder encoder = JsonEncoder.withIndent('  ');

      globals.loginData = json.decode(response.body);
      final responseData = json.decode(response.body) as Map;

      //getLog();

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = globals.chave;
      if (responseData.containsKey('hospede')) {
        _userId = responseData['hospede']['_id'];
        getLog();
      }
      if (responseData.containsKey('funcionario')) {
        _userId = responseData['funcionario']['_id'];
        getLogFunc();
      }
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'email': email,
          'password': password,
          'perfil': globals.perfil,
          'loginData': globals.loginData,
        },
      );
      prefs.setString('userData', userData);
      prefs.setString(
          'rememberMe', globals.rememberMe == true ? 'true' : 'false');
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    globals.naoTenta = false;
    return _authenticate(email, password, 'http', 'api/login');
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    globals.email = null;
    globals.password = null;
    globals.perfil = null;
    globals.naoTenta = true;
    SEGURANCA_DATA.clear();
    globals.channel?.sink.close();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.clear();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('rememberMe')) {
      if (prefs.getString('rememberMe') == 'false') {
        return false;
      }
    }
    if (!prefs.containsKey('userData')) {
      return false;
    }
    //getLog();
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    _token = extractedUserData['token'] as String;
    _userId = extractedUserData['userId'] as String;
    globals.perfil = extractedUserData['perfil'] == null
        ? null
        : extractedUserData['perfil'] as String;
    globals.loginData = extractedUserData['loginData'] == null
        ? null
        : extractedUserData['loginData'] as Map;

    notifyListeners();

    return true;
  }
}

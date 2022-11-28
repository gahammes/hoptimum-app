import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:hoptimum/models/hospede.dart';
import 'package:hoptimum/models/notificacao.dart';
import 'package:hoptimum/models/pedido.dart';
import 'package:hoptimum/models/report.dart';
import 'package:hoptimum/models/servico.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals.dart' as globals;
import '../http_exception.dart';
import '../../models/seguranca.dart';
import '../../models/despesa.dart';

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
        List reservaList = json.decode(response.body)['hospede']['reservas'];
        if (reservaList == null || reservaList.isEmpty) {
          globals.perfil = 'hospede-sem-reserva';
        } else {
          globals.perfil = 'hospede';
        }
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
        List reservaList = json.decode(response.body)['hospede']['reservas'];
        if (reservaList == null || reservaList.isEmpty) {
        } else {
          getLog();
          getDepesaLog();
          getPedidosHosp();
        }
        _userId = responseData['hospede']['_id'];
      }
      if (responseData.containsKey('funcionario')) {
        _userId = responseData['funcionario']['_id'];
        getLogFunc();
        if (responseData['funcionario']['cargo']['nome'] == 'cozinha') {
          getPedidos();
        }
        if (responseData['funcionario']['cargo']['nome'] == 'limpeza') {
          getServicos();
        }
        if (responseData['funcionario']['cargo']['nome'] == 'segurança') {
          getReportes();
        }
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
          'naoTenta': globals.naoTenta,
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
    globals.naoTenta = true;
    return _authenticate(email, password, 'http', 'api/login');
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    globals.email = null;
    globals.password = null;
    globals.perfil = null;
    globals.naoTenta = false;
    segurancaLog.clear();
    hospedeList.clear();
    despesasLog.clear();
    pedidosList.clear();
    pedidosFinalizadosList.clear();
    hospedeList.clear();
    reportesList.clear();
    servicosList.clear();
    servicosFinalizadosList.clear();
    globals.servicoList.clear();
    globals.carrosArray.clear();
    globals.quartosList.clear();
    globals.hospedesList.clear();
    globals.newStatus.clear();
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
    globals.naoTenta = extractedUserData['naoTenta'];
    if (globals.perfil == 'hospede') {
      getPedidosHosp();
      getDepesaLog();
      getLog();
    }
    if (globals.perfil == 'seguranca') {
      getLogFunc();
      getReportes();
    }
    if (globals.perfil == 'limpeza') {
      getLogFunc();
      getServicos();
    }
    if (globals.perfil == 'cozinha') {
      getLogFunc();
      getPedidos();
    }

    notifyListeners();

    return true;
  }
}

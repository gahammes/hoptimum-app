import 'dart:convert';
import 'dart:async';
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

  // Future<void> _postLogin(String email, String password) async {
  //   var negocio = json.encode({
  //     'email': email,
  //     'senha': password,
  //     'id': globals.chaveBackUp,
  //   });
  //   var response = await http.post(
  //     Uri.parse(globals.url('http', 'api/login')),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: negocio,
  //   );

  //   JsonEncoder encoder = JsonEncoder.withIndent('  ');

  //   //print(encoder.convert(json.decode(response.body)));
  //   print(json.decode(response.body)['hospede']['_id']);
  // }

  Future<void> _authenticate(String email, String password,
      String urlSegmentStart, String urlSegmentEnd) async {
    final url = Uri.parse(globals.url(urlSegmentStart, urlSegmentEnd));
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
      JsonEncoder encoder = JsonEncoder.withIndent('  ');
      print(encoder.convert(json.decode(response.body)));
      globals.loginData = json.decode(response.body);

      //print(json.decode(response.body)['hospede']['_id']);
      //print(json.decode(response.body));

      globals.loginData = json.decode(response.body);
      final responseData = json.decode(response.body) as Map;
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = globals.chave;
      if (responseData.containsKey('hospede')) {
        _userId = responseData['hospede']['_id'];
      }
      if (responseData.containsKey('funcionario')) {
        _userId = responseData['funcionario']['_id'];
      }

      // _expiryDate = DateTime.now().add(
      //   Duration(
      //     seconds: int.parse(
      //       responseData['expiresIn'],
      //     ),
      //   ),
      // );
      //_autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'email': email,
          'password': password,
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'http', 'api/login');
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    globals.email = null;
    globals.password = null;
    globals.channel?.sink.close();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    _token = extractedUserData['token'] as String;
    _userId = extractedUserData['userId'] as String;

    notifyListeners();

    return true;
  }
}

library hoptimum.globals;

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

IOWebSocketChannel? channel;
String url = 'http://e8ed-2804-7f4-3094-ecc7-7881-2b5b-5eff-753e.sa.ngrok.io/';

String getUrl(String start, String end) {
  url = url.replaceAll('http', '');
  return '$start$url$end';
}

const String heroInfoCard = 'info-card-hero';
const String heroReservaInfoCard = 'reserva-info-card-hero';

var perfil;

var email;
var password;
bool tryLog = false;

dynamic listenData;
dynamic loginData;
var chave;
var chaveBackUp;
var rememberMe;
bool naoTenta = true;
var listKey = GlobalKey<AnimatedListState>();
var tabIndex = 0;
var servicoList;

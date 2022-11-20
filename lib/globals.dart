library hoptimum.globals;

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

IOWebSocketChannel? channel;
String url = 'http://dff6-185-54-230-42.sa.ngrok.io/';

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
var servicoList = [];
var carrosArray = [];
var quartosList = [];

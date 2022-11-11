library hoptimum.globals;

import 'package:flutter/material.dart';

import 'package:web_socket_channel/io.dart';

IOWebSocketChannel? channel;
String url = 'http://4fef-2804-14c-8793-8e03-85be-b613-108b-effb.sa.ngrok.io/';

String getUrl(String start, String end) {
  url = url.replaceAll('http', '');
  return '$start$url$end';
  // return '$start://0c87-2804-7f4-3593-5911-3dd2-1958-e783-a23.sa.ngrok.io/$end';
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

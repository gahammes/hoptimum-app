library hoptimum.globals;

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

IOWebSocketChannel? channel;
String url = 'http://7c16-2804-14c-8793-8e03-85f9-a558-fec4-c077.sa.ngrok.io/';

String getUrl(String start, String end) {
  url = url.replaceAll('http', '');
  return '$start$url$end';
}

const String heroInfoCard = 'info-card-hero';
const String heroReservaInfoCard = 'reserva-info-card-hero';
const String heroHospInfoCard = 'hosp-info-hero';

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
var listKeyNotif = GlobalKey<AnimatedListState>();
var tabIndex = 0;
var servicoList = [];
var carrosArray = [];
var quartosList = [];
var hospedesList = [];
var reportesList = [];
var newStatus = {};

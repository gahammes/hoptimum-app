// ignore_for_file: prefer_typing_uninitialized_variables

library hoptimum.globals;

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

IOWebSocketChannel? channel;
String url = 'http://fcc0-2804-14c-bd80-8650-8576-eaf2-83ac-b0a7.sa.ngrok.io/';

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

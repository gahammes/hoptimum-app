library hoptimum.globals;

import 'package:web_socket_channel/io.dart';

IOWebSocketChannel? channel;
var urlWs = 'ws://17e0-2804-7f4-3592-bac2-9858-fe99-1e1f-7ed7.sa.ngrok.io/';
var urlApi =
    'http://17e0-2804-7f4-3592-bac2-9858-fe99-1e1f-7ed7.sa.ngrok.io/api';
// var url = 'http://0c87-2804-7f4-3593-5911-3dd2-1958-e783-a23.sa.ngrok.io/';

//://9d49-2804-14c-8793-8e03-8068-da36-69d6-124.sa.ngrok.io/ fari
//://0c87-2804-7f4-3593-5911-3dd2-1958-e783-a23.sa.ngrok.io/ dudu
// var url = (String start, String end) =>
//     '$start://0c87-2804-7f4-3593-5911-3dd2-1958-e783-a23.sa.ngrok.io/$end';
String url = 'http://7107-2804-14c-8793-8e03-c432-ef52-da91-1799.sa.ngrok.io/';
//TODO:MUDAR AQUI
String getUrl(String start, String end) {
  url = url.replaceAll('http', '');
  return '$start$url$end';
  // return '$start://0c87-2804-7f4-3593-5911-3dd2-1958-e783-a23.sa.ngrok.io/$end';
}

var perfil;

var email;
var password;
bool tryLog = false;

dynamic listenData;
dynamic loginData;
var chave;
var chaveBackUp;
var rememberMe;

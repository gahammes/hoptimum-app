// Future<String> getString(String url) => HttpClient()
//     .getUrl(Uri.parse(url))
//     .then((HttpClientRequest request) => request.close())
//     .then((HttpClientResponse response) =>
//         response.transform(utf8.decoder).join());

// dynamic handleContent(String content) {
//   var res = jsonDecode(content);
//   var newData = Seguranca(
//     id: 's1',
//     title: 'Uso do cartao-chave',
//     info: 'Quarto',
//     date: res['createdAt'],
//     tag: 'tag',
//   );
//   setState(() {
//     SEGURANCA_DATA.add(newData);
//   });
//   //print(res['message']);
// }

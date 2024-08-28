import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _itens = [];
  void _carregarCotacoes() async {
    String url = "https://blockchain.info/ticker";
    http.Response response;
    response = await http.get(Uri.parse(url));
    var map = json.decode(response.body);
    var tempList = [];
    map.forEach((key, value) {
      tempList.add({'moeda': key, 'valor': value["buy"]});
    });

    setState(() {
      _itens = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    _carregarCotacoes();
    return Scaffold(
      appBar: AppBar(
        title: Text("Carregando dados em lista"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: _itens.length,
          itemBuilder: (context, indice) {
            return ListTile(
              onTap: () {
                print("on tap");
              },
              onLongPress: () {
                print("Long press");
              },
              title: Text(_itens[indice]["moeda"]),
              subtitle: Text(_itens[indice]["valor"].toString()),
            );
          }),
    );
  }
}

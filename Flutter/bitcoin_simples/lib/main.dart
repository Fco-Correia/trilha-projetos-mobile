import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _recuperarCotacao() async {
    String url = "https://blockchain.info/ticker";
    http.Response response;
    response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      _valor = retorno["BRL"]["buy"];
    });
  }

  double _valor = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(40),
            child: Image.asset("images/bitcoin.png"),
          ),
          Text(
            'R\$ $_valor',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              _recuperarCotacao();
            },
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.orange)),
            child: const Text(
              "Atualizar",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )
        ],
      ),
    ));
  }
}

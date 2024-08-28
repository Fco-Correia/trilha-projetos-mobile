import 'package:flutter/material.dart';
import 'dart:math';

import 'Resultado.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _exibirResultado() {
    var indice = Random().nextInt(2);
    var resultados = ["images/moeda_cara.png", "images/moeda_coroa.png"];
    var resultado = resultados[indice];
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Resultado(resultado)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff61bd86),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 150),
                child: Image.asset("images/logo(3).png")),
            Padding(
                padding: EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: _exibirResultado,
                  child: Image.asset("images/botao_jogar.png"),
                ))
          ],
        )),
      ),
    );
  }
}

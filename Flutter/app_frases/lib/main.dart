import 'package:flutter/material.dart';
import 'dart:math';

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
    final _frases = ["Frase1", "Frase2", "Frase3", "Frase4", "Frase5"];
    var _fraseGerada = "Clique abaixo para gerar uma frase:";

    void _gerarFrase() {
        var numeroSorteado = Random().nextInt(_frases.length);
        setState(() {
            _fraseGerada = _frases[numeroSorteado];
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Frases do dia'),
                backgroundColor: Colors.green,
            ),
            body: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration:
                    BoxDecoration(border: Border.all(width: 3, color: Colors.amber)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        Image.asset("images/logo.png"),
                        Text(_fraseGerada,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.italic,
                                color: Colors.black)),
                        TextButton(
                            onPressed: () {
                                _gerarFrase();
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            child: const Text(
                                "Nova frase",
                                style: TextStyle(fontSize: 22, color: Colors.white),
                            ),
                        ),
                    ],
                ),
            ));
        }
    }

import 'package:flutter/material.dart';

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
  TextEditingController _controllerAlcool = TextEditingController();
  TextEditingController _controllerGasolina = TextEditingController();

  var resultado = "Resultado:";
  void Melhor() {
    if (_controllerAlcool.text.isNotEmpty &&
        _controllerGasolina.text.isNotEmpty) {
      double? alcool = double.tryParse(_controllerAlcool.text);
      double? gasolina = double.tryParse(_controllerGasolina.text);
      if ((alcool! / gasolina!) >= 0.7) {
        setState(() {
          resultado = "Resultado: Gasolina";
        });
      } else {
        setState(() {
          resultado = "Resultado: Alcool";
        });
      }

      _limparCampos();
    }
  }

  void _limparCampos() {
    _controllerAlcool.text = "";
    _controllerGasolina.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Alcool ou gasolina"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
            child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Image.asset("images/carro.png")),
              const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Saiba qual a melhor opção para abastecimento do seu carro",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Preço Alcool, ex: 1.59"),
                    style: const TextStyle(fontSize: 22),
                    controller: _controllerAlcool),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Preço Gasolina, ex: 3.15"),
                    style: const TextStyle(fontSize: 22),
                    controller: _controllerGasolina),
              ),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: TextButton(
                    onPressed: () {
                      Melhor();
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.blue)),
                    child: const Text("Calcular",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  resultado,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        )));
  }
}

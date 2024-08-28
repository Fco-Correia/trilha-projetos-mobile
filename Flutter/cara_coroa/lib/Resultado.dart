import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Resultado extends StatefulWidget {
  String resultado;
  Resultado(this.resultado);

  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  void _voltarTela() {
    Navigator.pop(context);
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
                child: Image.asset(widget.resultado),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: _voltarTela,
                  child: Image.asset("images/botao_voltar.png"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

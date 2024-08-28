import 'package:flutter/material.dart';

import 'TelaCliente.dart';
import 'TelaContato.dart';
import 'TelaEmpresa.dart';
import 'TelaServico.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _abrirEmpresa() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaEmpresa()));
  }

  void _abrirServico() {
    Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => TelaServico()));
  }

  void _abrirCliente() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaCliente()));
  }

  void _abrirContato() {
    Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => TelaContato()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ATM Consultoria"),
          backgroundColor: Colors.green,
        ),
        body: Container(
            width: double.infinity,
            child: SingleChildScrollView(
                padding: EdgeInsets.all(40),
                child: Column(
              children: [
                Image.asset("images/logo(2).png"),
                Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: _abrirEmpresa,
                        child: Image.asset("images/menu_empresa.png"),
                      ),
                      GestureDetector(
                          onTap: _abrirServico,
                          child: Image.asset("images/menu_servico.png"))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: _abrirCliente,
                          child: Image.asset("images/menu_cliente.png")),
                      GestureDetector(
                          onTap: _abrirContato,
                          child: Image.asset("images/menu_contato.png"))
                    ],
                  ),
                )
              ],
            ))));
  }
}

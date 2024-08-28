import 'package:flutter/material.dart';

class TelaCliente extends StatefulWidget {
  @override
  _TelaClienteState createState() => _TelaClienteState();
}

class _TelaClienteState extends State<TelaCliente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela Cliente"),
        backgroundColor: Colors.lightGreen,
      ),
      body:Container(
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Image.asset("images/detalhe_cliente.png"),
                    Text("Clientes")
                  ],),
              ),
              Padding(
                
                padding: EdgeInsets.all(20),
                child:Column(
                  children: [
                    Image.asset("images/cliente1.png"),
                    Image.asset("images/cliente2.png")
                  ],)
                )
            ],),
        )
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whatsapp/Login.dart';
import 'package:whatsapp/telas/AbaContatos.dart';
import 'package:whatsapp/telas/AbaConversas.dart';
import 'dart:io';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> itensMenu = ["Configurações", "Deslogar"];

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Configurações":
        Navigator.pushNamed(context,"/configuracoes");
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }

  _deslogarUsuario() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  Future verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    //auth.signOut();
    User? usuarioLogado = auth.currentUser;
    if (usuarioLogado == null) {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  void initState() {
    //adiar a chamada para verificarUsuarioLogado() até que o widget seja totalmente construído.
    Future.delayed(Duration.zero, () {
      verificarUsuarioLogado();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("WhatsApp", style: TextStyle(color: Colors.white)),
            elevation: Platform.isIOS ? 0 : 4,
            iconTheme: const IconThemeData(
              color: Colors.white, // Define a cor da seta de retorno
            ),
            backgroundColor: Color(0xff075E54),
            bottom: const TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                unselectedLabelColor: Colors.white,
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    text: "Conversas",
                  ),
                  Tab(
                    text: "Contatos",
                  )
                ]),
            actions: [
              PopupMenuButton<String>(
                  onSelected: _escolhaMenuItem,
                  itemBuilder: (context) {
                    return itensMenu.map((String item) {
                      return PopupMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList();
                  })
            ],
          ),
          body: TabBarView(children: [AbaConversas(), AbaContatos()]),
        ));
  }
}

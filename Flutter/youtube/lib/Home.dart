import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/telas/Biblioteca.dart';
import 'package:youtube/telas/EmAlta.dart';
import 'package:youtube/telas/Inscricoes.dart';
import 'package:youtube/telas/inicio.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indiceAtual = 0;
  String? _resultado = "";
  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [Inicio(_resultado!), EmAlta(), Inscricoes(), Biblioteca()];
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.grey,
          opacity: 1,
        ),
        title: Image.asset(
          "images/youtube.png",
          width: 98,
          height: 22,
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () async {
                String? res = await showSearch(
                    context: context, 
                    delegate: CustomSearchDelegate());
                setState(() {
                  _resultado = res;
                });
                print("resultado: digitado $res");
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _indiceAtual,
        onTap: (indice) {
          setState(() {
            _indiceAtual = indice;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
              //backgroundColor: Colors.orange,
              label: "Inicio",
              icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              //backgroundColor: Colors.red,
              label: "Em alta",
              icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(
              //backgroundColor: Colors.blue,
              label: "Inscrições",
              icon: Icon(Icons.subscriptions)),
          BottomNavigationBarItem(
              //backgroundColor: Colors.green,
              label: "Bibliotexa",
              icon: Icon(Icons.folder))
        ],
      ),
    );
  }
}

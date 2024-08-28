import 'package:aprenda_ingles/Bichos.dart';
import 'package:aprenda_ingles/Numeros.dart';
import 'package:aprenda_ingles/Vogais.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0, 
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: const Text("Aprenda inglês",style: TextStyle(color: Colors.white,fontSize: 25,
              fontWeight: FontWeight.bold),),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
            tabs: [
              Tab(
                text: "Bichos",
              ),
              Tab(
                text: "Números",
              ),
              Tab(
                text: "Vogais",
              ),
            ]
          ),
        ),
        body: TabBarView(
          children: [
            Bichos(),
            Numeros(),
            Vogais()
          ],),
      )
    );
  }
}

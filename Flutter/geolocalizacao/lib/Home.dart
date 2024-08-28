import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocalizacao/Mapa.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /*
  List _listaViagens = [
    "Cristo Redentor",
    "Grande Muralha da China",
    "Taj Mahal",
    "Machu Picchu",
    "Coliseu"
  ];
  */
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final _controller = StreamController<QuerySnapshot>.broadcast();

  _abrirMapa(String idViagem) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => Mapa( idViagem: idViagem )));
  }

  _excluirViagem(String idViagem) {
    _db.collection("viagens").doc(idViagem).delete();
  }

  _adicionarLocal() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => Mapa()));
  }

  _adicionarListenerViagens() async {
    final stream = _db.collection("viagens").snapshots();
    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  @override
  void initState() {
    super.initState();
    _adicionarListenerViagens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Minhas viagens"),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Color(0xff0066cc),
            onPressed: () {
              _adicionarLocal();
            }),
        body: StreamBuilder<QuerySnapshot>(
          stream: _controller.stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child:
                        CircularProgressIndicator()); //sem isso tava dando erro porque o waiting meio que nao tava sendo excutado e indo direto pro done
              case ConnectionState.active:
              case ConnectionState.done:
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Nenhuma viagem encontrada'));
                }
                QuerySnapshot querySnapshot = snapshot.data!;
                List<DocumentSnapshot> viagens = querySnapshot.docs.toList();

                return Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                          itemCount: viagens.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot item = viagens[index];
                            String titulo = item["titulo"];
                            String idViagem = item.id;
                            return GestureDetector(
                              onTap: () {
                                _abrirMapa(idViagem);
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(titulo),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          _excluirViagem(idViagem);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Icon(
                                            Icons.remove_circle,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                );
            }
          },
        ));
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx/models/Anuncio.dart';
import 'package:olx/utils/Configuracoes.dart';
import 'package:olx/views/widgets/ItemAnuncio.dart';

class Anuncios extends StatefulWidget {
  @override
  _AnunciosState createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {
  final _controller = StreamController.broadcast();
  List<String> itensMenu = [];
  String? _itemSelecionadoEstado;
  String? _itemSelecioandoCategoria;
  List<DropdownMenuItem<String>> _listaItensDropCategorias = [];
  List<DropdownMenuItem<String>> _listaItensDropEstados = [];

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Meus anúncios":
        Navigator.pushNamed(context, "/meus-anuncios");
        break;
      case "Entrar/Cadastrar":
        Navigator.pushNamed(context, "/login");
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = await auth.currentUser;

    if (usuarioLogado == null) {
      itensMenu = ["Entrar/Cadastrar"];
    } else {
      itensMenu = ["Meus anúncios", "Deslogar"];
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    Navigator.pushNamed(context, "/login");
    await auth.signOut();
    setState(() {
      itensMenu = ["Entrar/Cadastrar"];
    });
  }

  _carregarItensDropdown() {
    //Categorias
    _listaItensDropCategorias = Configuracoes.getCategorias();

    //Estados
    _listaItensDropEstados = Configuracoes.getEstados();
  }

  Future<Stream> _adicionarListenerAnuncios() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream stream = db.collection("anuncios").snapshots();
    stream.listen((dados) {
      _controller.add(dados);
    });
    return stream;
  }

  Future<Stream> _filtrarAnuncios() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Query query = db.collection("anuncios");
    if (_itemSelecionadoEstado != null) {
      query = query.where("estado", isEqualTo: _itemSelecionadoEstado);
    }
    if (_itemSelecioandoCategoria != null) {
      query = query.where("categoria", isEqualTo: _itemSelecioandoCategoria);
    }
    Stream stream = query.snapshots();
    stream.listen((dados) {
      _controller.add(dados);
    });
    return stream;
  }

  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();
    _verificarUsuarioLogado();
    _adicionarListenerAnuncios();
  }

  @override
  Widget build(BuildContext context) {
    var carregandoDados = const Center(
      child: Column(
        children: [Text("Carregando anúncios"), CircularProgressIndicator()],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "OLX",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff9c27b0),
        elevation: 0,
        actions: [
          PopupMenuButton(onSelected: (dynamic item) {
            _escolhaMenuItem(item);
          }, itemBuilder: (context) {
            return itensMenu.map((String item) {
              return PopupMenuItem(value: item, child: Text(item));
            }).toList();
          })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: DropdownButtonHideUnderline(
                  child: Center(
                    child: DropdownButton(
                      iconEnabledColor: Color(0xff9c27b0),
                      value: _itemSelecionadoEstado,
                      items: _listaItensDropEstados,
                      style: TextStyle(fontSize: 22, color: Colors.black),
                      onChanged: (estado) {
                        setState(() {
                          _itemSelecionadoEstado = estado;
                          _filtrarAnuncios();
                        });
                      },
                    ),
                  ),
                )),
                Container(
                  color: Colors.grey[200],
                  width: 2,
                  height: 60,
                ),
                Expanded(
                    child: DropdownButtonHideUnderline(
                  child: Center(
                    child: DropdownButton(
                      iconEnabledColor: Color(0xff9c27b0),
                      value: _itemSelecioandoCategoria,
                      items: _listaItensDropCategorias,
                      style: TextStyle(fontSize: 22, color: Colors.black),
                      onChanged: (categoria) {
                        setState(() {
                          _itemSelecioandoCategoria = categoria;
                          _filtrarAnuncios();
                        });
                      },
                    ),
                  ),
                )),
              ],
            ),
            StreamBuilder(
                stream: _controller.stream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      break;
                    case ConnectionState.waiting:
                      return carregandoDados;
                    case ConnectionState.active:
                      QuerySnapshot querySnapshot = snapshot.data;
                      if (querySnapshot.docs.length == 0) {
                        return Container(
                          padding: EdgeInsets.all(25),
                          child: Text(
                            "Nenhum anuncio! :(",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                      return Expanded(
                          child: ListView.builder(
                              itemCount: querySnapshot.docs.length,
                              itemBuilder: (context, indice) {
                                List anuncios = querySnapshot.docs.toList();
                                DocumentSnapshot documentSnapshot =
                                    anuncios[indice];
                                Anuncio anuncio = Anuncio.fromDocumentSnapshot(
                                    documentSnapshot);
                                return ItemAnuncio(
                                  anuncio: anuncio,
                                  onTapItem: () {
                                    Navigator.pushNamed(context, "/detalhes-anuncio",arguments: anuncio);
                                  },
                                );
                              }));
                    case ConnectionState.done:
                      break;
                  }
                  return Container();
                })
          ],
        ),
      ),
    );
  }
}

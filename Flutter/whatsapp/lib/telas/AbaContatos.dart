import 'package:flutter/material.dart';
import 'package:whatsapp/model/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AbaContatos extends StatefulWidget {
  @override
  _AbaContatosState createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  // ignore: unused_field
  String? _idUsuarioLogado;
  String? _emailUsuarioLogado;

  Future<List<Usuario>> _recuperarContatos() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    
    QuerySnapshot querySnapshot = await db.collection("usuarios").get();
    List<Usuario> listaUsuarios = [];
    for (DocumentSnapshot item in querySnapshot.docs) {
      var dados = item.data() as Map<String, dynamic>;
      if (dados["email"] == _emailUsuarioLogado)
        continue; // nao mostra o usuario logado

      Usuario usuario = Usuario();
      usuario.idUsuario = item.id;
      usuario.email = dados["email"];
      usuario.name = dados["nome"];
      usuario.urlImagem = dados["urlImagem"];
      listaUsuarios.add(usuario);
    }
    return listaUsuarios;
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = auth.currentUser!;
    _idUsuarioLogado = usuarioLogado.uid;
    _emailUsuarioLogado = usuarioLogado.email;
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _recuperarContatos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Column(
                  children: [
                    Text("Carregando contatos"),
                    CircularProgressIndicator()
                  ],
                ),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              return ListView.builder(
                  itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                  itemBuilder: (context, indice) {
                    List<Usuario> listaItens = snapshot.data!;
                    Usuario usuario = listaItens[indice];
                    return ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, "/mensagens",
                              arguments: usuario);
                        },
                        contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: usuario.urlImagem != null
                                ? NetworkImage(usuario.urlImagem!)
                                : null),
                        title: Text(
                          usuario.name!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ));
                  });
          }
        });
  }
}

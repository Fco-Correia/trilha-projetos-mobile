import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber/utils/StatusRequisicao.dart';
import 'package:uber/utils/UsuarioFirebase.dart';

class PainelMotorista extends StatefulWidget {
  @override
  _PainelMotoristaState createState() => _PainelMotoristaState();
}

class _PainelMotoristaState extends State<PainelMotorista> {

  List<String> itensMenu = [
    "Configurações", "Deslogar"
  ];
  final _controller = StreamController<QuerySnapshot>.broadcast();
  FirebaseFirestore db = FirebaseFirestore.instance;

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/");
  }

  _escolhaMenuItem(String escolha) {
    switch (escolha) {
      case "Deslogar":
        _deslogarUsuario();
        break;
      case "Configurações":
        // Implementar ação para configurações se necessário
        break;
    }
  }
  
  StreamSubscription<QuerySnapshot>? _listenerRequisicoes;

  void _adicionarListenerRequisicoes() {
    _listenerRequisicoes = db.collection("requisicoes")
        .where("status", isEqualTo: StatusRequisicao.AGUARDANDO)
        .snapshots()
        .listen((dados) {
          _controller.add(dados);
        });
  }

  @override
  void initState() {
    super.initState();
    _recuperaRequisicaoAtivaMotorista();
  }

  @override
  void dispose() {
    _listenerRequisicoes?.cancel();
    _controller.close();
    super.dispose();
  }

  Future<void> _recuperaRequisicaoAtivaMotorista() async {
    User? firebaseUser = await UsuarioFirebase.getUsuarioAtual();
    
    if (firebaseUser == null) {
      // Caso o usuário não esteja logado
      return;
    }
    
    DocumentSnapshot documentSnapshot = await db
        .collection("requisicao_ativa_motorista")
        .doc(firebaseUser.uid)
        .get();
    
    if (!documentSnapshot.exists) {
      _adicionarListenerRequisicoes();
    } else {
      // Se existir, extrai os dados da requisição
      Map<String, dynamic>? dadosRequisicao = documentSnapshot.data() as Map<String, dynamic>?;

      if (dadosRequisicao == null || !dadosRequisicao.containsKey("id_requisicao")) {
        return;
      }
      
      String idRequisicao = dadosRequisicao["id_requisicao"];
      
      Navigator.pushNamed(context, "/corrida", arguments: idRequisicao);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel motorista"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao carregar os dados!"),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("Você não tem nenhuma requisição :(",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (context, index) => Divider(
                height: 2,
                color: Colors.grey,
              ),
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                String idRequisicao = document["id"];
                String nomePassageiro = document["passageiro"]["nome"];
                String rua = document["destino"]["rua"];
                String numero = document["destino"]["numero"];

                return ListTile(
                  title: Text(nomePassageiro),
                  subtitle: Text("Destino: $rua, $numero"),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      "/corrida",
                      arguments: idRequisicao,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

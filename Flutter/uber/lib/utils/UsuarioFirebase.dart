import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber/models/Usuario.dart';

class UsuarioFirebase {
  static Future<User?> getUsuarioAtual() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return await auth.currentUser;
  }

  static Future<Usuario?> getDadosUsuarioLogado() async {
    User? firebaseUser = await getUsuarioAtual();
    if (firebaseUser != null) {
      String idUsuario = firebaseUser.uid;

      FirebaseFirestore db = FirebaseFirestore.instance;

      DocumentSnapshot snapshot =
          await db.collection("usuarios").doc(idUsuario).get();

      Map<String, dynamic>? dados = snapshot.data() as Map<String, dynamic>?;
      String tipoUsuario = dados!["tipoUsuario"];
      String email = dados["email"];
      String nome = dados["nome"];

      Usuario usuario = Usuario();
      usuario.idUsuario = idUsuario;
      usuario.tipoUsuario = tipoUsuario;
      usuario.email = email;
      usuario.nome = nome;

      return usuario;
    }
    return null;
  }

  static atualizarDadosLocalizacao(
      String idRequisicao, double lat, double lon, String tipo) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    Usuario? usuario = await getDadosUsuarioLogado();
    if(usuario != null){
      usuario.latitude = lat;
      usuario.longitude = lon;

    db
        .collection("requisicoes")
        .doc(idRequisicao)
        .update({"${tipo}": usuario.toMap()});
    }
  }
}

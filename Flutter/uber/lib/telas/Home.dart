import 'package:flutter/material.dart';
import 'package:uber/models/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";
  bool _carregando = false;

  _validarCampos(){

    //Recuperar dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    //validar campos
    if( email.isNotEmpty && email.contains("@") ){

      if( senha.isNotEmpty && senha.length > 6 ){

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario( usuario );

      }else{
        setState(() {
          _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
        });
      }

    }else{
      setState(() {
        _mensagemErro = "Preencha o E-mail válido";
      });
    }

  }

  _logarUsuario( Usuario usuario ){

    setState(() {
      _carregando = true;
    });

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: usuario.email!,
        password: usuario.senha!
    ).then((firebaseUser){

      _redirecionaPainelPorTipoUsuario( firebaseUser.user!.uid );

    }).catchError((error){
      _mensagemErro = "Erro ao autenticar usuário, verifique e-mail e senha e tente novamente!";
    });

  }

  _redirecionaPainelPorTipoUsuario(String idUsuario) async {

    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentSnapshot snapshot = await db.collection("usuarios")
          .doc( idUsuario )
          .get();

    Map<String, dynamic>? dados = snapshot.data() as Map<String, dynamic>?;
    String tipoUsuario = dados!["tipoUsuario"];

    setState(() {
      _carregando = false;
    });

    switch( tipoUsuario ){
      case "motorista" :
        Navigator.pushReplacementNamed(context, "/painel-motorista");
        break;
      case "passageiro" :
        Navigator.pushReplacementNamed(context, "/painel-passageiro");
        break;
    }

  }

  _verificarUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;

    User? usuarioLogado = await auth.currentUser;
    if( usuarioLogado != null ){
      String idUsuario = usuarioLogado.uid;
      _redirecionaPainelPorTipoUsuario(idUsuario);
    }

  }

  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/fundo.png"),
              fit: BoxFit.cover
          )
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                      "images/logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                TextField(
                  controller: _controllerEmail,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "e-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),
                TextField(
                  controller: _controllerSenha,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _validarCampos();
                    },
                    style: const ButtonStyle(
                        backgroundColor: const WidgetStatePropertyAll<Color>(
                            Color(0xff1ebbd8)),
                        padding: WidgetStatePropertyAll<EdgeInsets>(
                            const EdgeInsets.fromLTRB(32, 16, 32, 16))),
                    child: const Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                        "Não tem conta? cadastre-se!",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, "/cadastro");
                    },
                  ),
                ),
                _carregando
                    ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),)
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

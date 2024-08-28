import "package:flutter/material.dart";
import "package:whatsapp/Cadastro.dart";
import "package:whatsapp/Configuracoes.dart";
import "package:whatsapp/Home.dart";
import "package:whatsapp/Login.dart";
import "package:whatsapp/Mensagens.dart";
import "package:whatsapp/model/Usuario.dart";

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => Login());
      case "/login":
        return MaterialPageRoute(builder: (context) => Login());
      case "/cadastro":
        return MaterialPageRoute(builder: (context) => Cadastro());
      case "/home":
        return MaterialPageRoute(builder: (context) => Home());
      case "/configuracoes":
        return MaterialPageRoute(builder: (context) => Configuracoes());
      case "/mensagens":
        if (args is Usuario) {
          return MaterialPageRoute(builder: (context) => Mensagens(args));
        }

      default:
        _errorRota();
    }
    return null;
  }

  static Route<dynamic> _errorRota() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela não encontrada"),
        ),
        body: Center(
          child: Text("Tela não encontrada"),
        ),
      );
    });
  }
}

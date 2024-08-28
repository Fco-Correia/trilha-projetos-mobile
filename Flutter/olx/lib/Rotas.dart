import 'package:flutter/material.dart';
import 'package:olx/models/Anuncio.dart';
import 'package:olx/views/Anuncios.dart';
import 'package:olx/views/DetalhesAnuncio.dart';
import 'package:olx/views/Login.dart';
import 'package:olx/views/MeusAnuncios.dart';
import 'package:olx/views/NovoAnuncio.dart';

class Rotas {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Anuncios());
      case "/login":
        return MaterialPageRoute(builder: (_) => Login());
      case "/meus-anuncios":
        return MaterialPageRoute(builder: (_) => MeusAnuncios());
      case "/novo-anuncio":
        return MaterialPageRoute(builder: (_) => NovoAnuncio());
      case "/detalhes-anuncio":
        return MaterialPageRoute(builder: (_) => DetalhesAnuncio(args as Anuncio?));
      default:
        _erroRota();
    }
    return _erroRota();
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela não encontrada"),
        ),
      );
    });
  }
}
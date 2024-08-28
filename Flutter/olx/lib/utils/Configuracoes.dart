import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class Configuracoes {
  //static chamar sem instancia
  static List<DropdownMenuItem<String>> getCategorias() {
    List<DropdownMenuItem<String>> itensDropCategorias = [];
    itensDropCategorias
        .add(DropdownMenuItem(child: Text("Categoria",style: TextStyle(color: Color(0xff9c27b0)),), value: null));
    
    itensDropCategorias
        .add(DropdownMenuItem(child: Text("Automóvel"), value: "auto"));

    itensDropCategorias
        .add(DropdownMenuItem(child: Text("Imóvel"), value: "imovel"));

    itensDropCategorias
        .add(DropdownMenuItem(child: Text("Eletônicos"), value: "eletro"));

    itensDropCategorias
        .add(DropdownMenuItem(child: Text("Moda"), value: "moda"));

    itensDropCategorias
        .add(DropdownMenuItem(child: Text("Esportes"), value: "esportes"));

    return itensDropCategorias;
  }

  static List<DropdownMenuItem<String>> getEstados() {
    List<DropdownMenuItem<String>> itensDropEstados = [];
    itensDropEstados
        .add(DropdownMenuItem(child: Text("Região",style: TextStyle(color: Color(0xff9c27b0)),), value: null));
    
    for (var estado in Estados.listaEstadosSigla) {
      itensDropEstados.add(DropdownMenuItem(
        child: Text(estado),
        value: estado,
      ));
    }
    return itensDropEstados;
  }
}

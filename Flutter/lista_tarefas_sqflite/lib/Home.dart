import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas_sqflite/helper/AnotacaoHelper.dart';
import 'package:lista_tarefas_sqflite/model/Anotacao.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();
  var _db = AnotacaoHelper();
  List<Anotacao> _anotacoes = [];
  _exibirTelaCadastro({Anotacao? anotacao}) {
    String textoSalvarAtualizar = "";
    if (anotacao == null) {
      _controllerDescricao.text = "";
      _controllerTitulo.text = "";
      textoSalvarAtualizar = "Salvar";
    } else {
      _controllerTitulo.text = anotacao.titulo ?? "";
      _controllerDescricao.text = anotacao.descricao ?? "";
      textoSalvarAtualizar = "Atualizar";
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Adicionar anotação"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _controllerTitulo,
                  decoration: const InputDecoration(
                      labelText: "Título",
                      hintText: "Digite título...",
                      hintStyle: TextStyle(fontSize: 12)),
                  onChanged: (text) {},
                ),
                TextField(
                  controller: _controllerDescricao,
                  decoration: const InputDecoration(
                      labelText: "Descrição",
                      hintText: "Digite descrição...",
                      hintStyle: TextStyle(fontSize: 12)),
                  onChanged: (text) {},
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    _salvarAnotacao(anotacaoSelecionada: anotacao);
                    Navigator.pop(context);
                  },
                  child: Text("$textoSalvarAtualizar")),
            ],
          );
        });
  }

  _recuperarAnotacoes() async {
    List anotacoesRecuperadas = await _db.recuperarAnotacoes();
    List<Anotacao> listaTemporaria = [];

    for (var item in anotacoesRecuperadas) {
      Anotacao anotacao = Anotacao.fromMap(item);
      listaTemporaria.add(anotacao);
    }

    setState(() {
      _anotacoes = listaTemporaria;
    });

    listaTemporaria = [];
    //print("Lista anotacoes" + anotacoesRecuperadas.toString());
  }

  _salvarAnotacao({Anotacao? anotacaoSelecionada}) async {
    String titulo = _controllerTitulo.text;
    String descricao = _controllerDescricao.text;
    if (anotacaoSelecionada == null) {
      Anotacao anotacao =
          Anotacao(titulo, descricao, DateTime.now().toString());
      int resultado = await _db.salvarAnotacao(anotacao);
    } else {
      anotacaoSelecionada.titulo = titulo;
      anotacaoSelecionada.descricao = descricao;
      int resultado = await _db.atualizarAnotacao(anotacaoSelecionada);
    }

    _controllerTitulo.clear();
    _controllerDescricao.clear();
  }

  _formatarData(String? data) {
    if (data == null || data.isEmpty) {
      return 'Data inválida';
    }

    initializeDateFormatting("pr_BR");
    //var formater = DateFormat("d/M/y H:m:s");
    var formater = DateFormat.yMd("pt_BR");
    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formater.format(dataConvertida);
    return dataFormatada;
  }

  _removerAnotacao(int? id) async {
    await _db.removerAnotacao(id!);
    _recuperarAnotacoes();
  }

  @override
  void initState() {
    super.initState();
    _recuperarAnotacoes();
  }

  @override
  Widget build(BuildContext context) {
    _recuperarAnotacoes();
    return Scaffold(
        appBar: AppBar(
          title: Text("Anotações"),
          backgroundColor: Colors.lightGreen,
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: _anotacoes.length,
                    itemBuilder: (context, index) {
                      final anotacao = _anotacoes[index];
                      return Card(
                        child: ListTile(
                          title: Text("${anotacao.titulo}"),
                          subtitle: Text(
                              "${_formatarData(anotacao.data)} - ${anotacao.descricao}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _exibirTelaCadastro(anotacao: anotacao);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Icon(Icons.edit, color: Colors.green),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _removerAnotacao(anotacao.id);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 0),
                                  child: Icon(Icons.remove_circle,
                                      color: Colors.red),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreen,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
          onPressed: () {
            _exibirTelaCadastro();
          },
        ));
  }
}

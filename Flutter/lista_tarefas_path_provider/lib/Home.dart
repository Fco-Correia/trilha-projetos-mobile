//path_provider para obter o diretório de documentos da aplicação e o pacote dart:io para manipular o sistema de arquivos. 
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listaTarefas = [];
  Map<String, dynamic> _ultimaTarefaRemovida = Map();
  TextEditingController _controllerTarefa = TextEditingController();

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }

  _salvarArquivo() async {
    var arquivo = await _getFile();
    String dados = json.encode(_listaTarefas);
    arquivo.writeAsString(dados);
  }

  _lerArquivo() async {
    try {
      final arquivo = await _getFile();
      // Verifica se o arquivo existe antes de tentar ler
      if (await arquivo.exists()) {
        return await arquivo.readAsString();
      } else {
        // Retorna uma string vazia se o arquivo não existir
        return "";
      }
    } catch (e) {
      print(e);
      return "";
    }
  }

  _salvarTarefa() {
    String textoDigitado = _controllerTarefa.text;
    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = textoDigitado;
    tarefa["realizada"] = false;
    setState(() {
      _listaTarefas.add(tarefa);
    });

    _salvarArquivo();
    _controllerTarefa.text = "";
  }

  @override
  void initState() {
    super.initState();
    _lerArquivo().then((dados) {
      if (dados != null && dados.isNotEmpty) {
        setState(() {
          _listaTarefas = json.decode(dados);
        });
      } else {
        _listaTarefas = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("itens:" + _listaTarefas.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lista de tarefas",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: _listaTarefas.length,
                  itemBuilder: (context, index) {
                    final item = _listaTarefas[index]["titulo"];
                    return Dismissible(
                        //background: Container(color: Colors.green),
                        //secondaryBackground: Container(color: Colors.red),
                        key: Key(item +
                            DateTime.now().millisecondsSinceEpoch.toString()),
                        direction: DismissDirection.endToStart,
                        //direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          _ultimaTarefaRemovida = _listaTarefas[index];
                          if (direction == DismissDirection.endToStart) {
                            setState(() {
                              _listaTarefas.removeAt(index);
                              _salvarArquivo();
                            });
                          }
                          final snackbar = SnackBar(
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 5),
                            content: Text("Tarefa removida!"),
                            action: SnackBarAction(
                                label: "Desfazer",
                                onPressed: () {
                                  setState(() {
                                    _listaTarefas.insert(
                                        index, _ultimaTarefaRemovida);
                                  });
                                  _salvarArquivo();
                                }),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        },
                        background: Container(
                          color: Colors.red,
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Icon(Icons.delete, color: Colors.white)],
                          ),
                        ),
                        child: CheckboxListTile(
                            title: Text(_listaTarefas[index]["titulo"]),
                            value: _listaTarefas[index]["realizada"],
                            onChanged: (valorAlterado) {
                              setState(() {
                                _listaTarefas[index]["realizada"] =
                                    valorAlterado;
                              });
                              _salvarArquivo();
                            }));
                    /*
                    return ListTile(
                      title: Text("tarefa: ${_listaTarefas[index]["titulo"]}"),
                    );
                    */
                  }))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          elevation: 6,
          //mini: true,
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Adicionar Tarefa"),
                    content: TextField(
                      controller: _controllerTarefa,
                      decoration:
                          InputDecoration(labelText: "Digite sua tarefa"),
                      onChanged: (text) {},
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancelar")),
                      TextButton(
                          onPressed: () {
                            _salvarTarefa();
                            Navigator.pop(context);
                          },
                          child: Text("Salvar"))
                    ],
                  );
                });
          }),
      //bottomNavigationBar: BottomNavigationBar(items: [],),
    );
  }
}

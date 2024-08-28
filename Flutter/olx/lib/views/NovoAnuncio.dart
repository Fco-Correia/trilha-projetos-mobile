import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olx/models/Anuncio.dart';
import 'package:olx/utils/Configuracoes.dart';
import 'package:olx/views/widgets/BotaoCustomizado.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx/views/widgets/InputCustomizado.dart';
import 'package:validadores/validadores.dart';

class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {
  final _formKey = GlobalKey<FormState>();

  List<XFile> _listaImagens = [];
  List<DropdownMenuItem<String>> _listaItensDropEstados = [];
  List<DropdownMenuItem<String>> _listaItensDropCategorias = [];

  String? _itemSelecionadoEstado;
  String? _itemSelecionadoCategoria;

  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerPreco = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();

  late Anuncio _anuncio;

  _selecionarImagemGaleria() async {
    XFile? imagemSelecionada =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagemSelecionada != null) {
      setState(() {
        _listaImagens.add(imagemSelecionada);
      });
    }
  }

  _carregarItensDropdown() {
    //Categorias
    _listaItensDropCategorias = Configuracoes.getCategorias();

    //Estados
    _listaItensDropEstados = Configuracoes.getEstados();
  }

  _salvarAnuncio() async {
    _abrirDialog(context);
    //Upload imagens no Storage
    await _uploadImagens();

    //Salvar anuncio no Firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = await auth.currentUser;
    String idUsuarioLogado = usuarioLogado!.uid;

    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("meus_anuncios")
        .doc(idUsuarioLogado)
        .collection("anuncios")
        .doc(_anuncio.id)
        .set(_anuncio.toMap())
        .then((_) {
      //Salvar anuncio publico
      db
          .collection("anuncios")
          .doc(_anuncio.id)
          .set(_anuncio.toMap())
          .then((_) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      });
    });
  }

  Future _uploadImagens() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();

    for (int i = 0; i < _listaImagens.length; i++) {
      String nomeImagem = '${_anuncio.id}_$i'; // Nome único para cada imagem
      Reference arquivo = pastaRaiz
          .child("meus_anuncios")
          .child(_anuncio.id!)
          .child(nomeImagem);
      UploadTask uploadTask = arquivo.putFile(File(_listaImagens[i].path));
      TaskSnapshot taskSnapshot = await uploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();
      _anuncio.fotos!.add(url);
    }
  }

  _abrirDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text("Salvando anúncio...")
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();
    _anuncio = Anuncio
        .gerarId(); //constutor nomeado,pra nao dar problema na instancia em MeusAnuncios
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Novo anúncio",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff9c27b0),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormField(
                    initialValue: _listaImagens,
                    validator: (imagens) {
                      if (imagens!.length == 0) {
                        return "Necessário selecionar uma imagem";
                      }
                      return null;
                    },
                    builder: (state) {
                      return Column(
                        children: [
                          Container(
                            height: 100,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _listaImagens.length +
                                    1, //conseguir colocar o de add
                                itemBuilder: (context, indice) {
                                  if (indice == _listaImagens.length) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          _selecionarImagemGaleria();
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey[400],
                                          radius: 50,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_a_photo,
                                                size: 40,
                                                color: Colors.grey[100],
                                              ),
                                              Text(
                                                "Adicionar",
                                                style: TextStyle(
                                                    color: Colors.grey[100]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  if (_listaImagens.length > 0) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                    child:
                                                        SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Image.file(File(
                                                          _listaImagens[indice]
                                                              .path)),
                                                      TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _listaImagens
                                                                  .removeAt(
                                                                      indice);
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  WidgetStateProperty
                                                                      .all(Colors
                                                                          .white)),
                                                          child: Text(
                                                            "Excluir",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          )),
                                                    ],
                                                  ),
                                                ));
                                              });
                                        },
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: FileImage(
                                              File(_listaImagens[indice].path)),
                                          child: Container(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.4),
                                            alignment: Alignment.center,
                                            child: const Icon(Icons.delete,
                                                color: Colors.red),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Container(); //so pra n ficar o amarelin
                                }),
                          ),
                          if (state.hasError)
                            Container(
                              child: Text(
                                "[${state.errorText}]",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 14),
                              ),
                            )
                        ],
                      );
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          items: _listaItensDropEstados,
                          value: _itemSelecionadoEstado,
                          hint: Text("Estados"),
                          onSaved: (estado) {
                            _anuncio.estado = estado;
                          },
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          validator: (valor) {
                            return Validador()
                                .add(Validar.OBRIGATORIO,
                                    msg: "Campo obrigatório")
                                .valido(valor);
                          },
                          onChanged: (valor) {
                            setState(() {
                              _itemSelecionadoEstado = valor;
                            });
                          },
                        ),
                      )),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          value: _itemSelecionadoCategoria,
                          hint: Text("Categoria"),
                          onSaved: (categoria) {
                            _anuncio.categoria = categoria;
                          },
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          items: _listaItensDropCategorias,
                          validator: (valor) {
                            return Validador()
                                .add(Validar.OBRIGATORIO,
                                    msg: "Campo obrigatório")
                                .valido(valor);
                          },
                          onChanged: (valor) {
                            setState(() {
                              _itemSelecionadoCategoria = valor;
                            });
                          },
                        ),
                      ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15, top: 15),
                    child: InputCustomizado(
                      controller: _controllerTitulo,
                      validator: (valor) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .valido(valor);
                      },
                      hint: "Título",
                      onSaved: (titulo) {
                        _anuncio.titulo = titulo;
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: InputCustomizado(
                      controller: _controllerPreco,
                      validator: (valor) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .valido(valor);
                      },
                      hint: "Preço",
                      type: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CentavosInputFormatter(moeda: true, casasDecimais: 2)
                      ],
                      onSaved: (preco) {
                        _anuncio.preco = preco;
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: InputCustomizado(
                      controller: _controllerTelefone,
                      validator: (valor) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .valido(valor);
                      },
                      hint: "Telefone",
                      type: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                      onSaved: (telefone) {
                        _anuncio.telefone = telefone;
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: InputCustomizado(
                      controller: _controllerDescricao,
                      validator: (valor) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .maxLength(200, msg: "Máximo de 200 caracteres")
                            .valido(valor);
                      },
                      hint: "Descrição (200 caracteres)",
                      maxLines: 10,
                      onSaved: (descricao) {
                        _anuncio.descricao = descricao;
                        return null;
                      },
                    ),
                  ),
                  BotaoCustomizado(
                      texto: "Cadastrar anúncio",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //salvar campos
                          _formKey.currentState!.save();
                          //Salvar anuncio
                          _salvarAnuncio();
                        }
                      })
                ],
              )),
        ),
      ),
    );
  }
}

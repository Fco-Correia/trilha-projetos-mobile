import 'package:flutter/material.dart';
import 'package:olx/models/Anuncio.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetalhesAnuncio extends StatefulWidget {
  final Anuncio? anuncio;
  DetalhesAnuncio(this.anuncio);

  @override
  _DetalhesAnuncioState createState() => _DetalhesAnuncioState();
}

class _DetalhesAnuncioState extends State<DetalhesAnuncio> {
  late Anuncio _anuncio;
  late List<String> listaImagens;
  int _currentImageIndex = 0;

  void _getListaImagens() {
    listaImagens = _anuncio.fotos!;
    print("************");
    print(listaImagens);
  }

  _ligarTelefone(String telefone) async {
    //if (await canLaunchUrl(Uri.parse("https://www.google.com"))) {
    //  await launchUrl(Uri.parse("https://www.google.com"));
    //}
    if (await canLaunchUrlString("tel:$telefone")) {
      await launchUrlString("tel:$telefone");
    } else {
      print("Não pode fazer a ligação");
    }
  }

  @override
  void initState() {
    super.initState();
    _anuncio = widget.anuncio!;
    _getListaImagens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Anúncio",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff9c27b0),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: 250,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 250.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                  ),
                  items: listaImagens.map((url) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(url),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Image.network(url, fit: BoxFit.cover),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0xff9c27b0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Text(
                                  "${_currentImageIndex + 1}/${listaImagens.length}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "R\$ ${_anuncio.preco}",
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff9c27b0)),
                    ),
                    Text(
                      "${_anuncio.titulo}",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    const Text("Descrição",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("${_anuncio.descricao}",
                        style: const TextStyle(fontSize: 18)),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    const Text("Contato",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: EdgeInsets.only(bottom:66),
                      child: Text("${_anuncio.telefone}", style: TextStyle(fontSize: 18)),
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: GestureDetector(
                onTap: () {
                  _ligarTelefone(_anuncio.telefone!);
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xff9c27b0),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    "Ligar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

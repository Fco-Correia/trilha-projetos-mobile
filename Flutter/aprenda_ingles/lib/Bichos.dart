import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Bichos extends StatefulWidget {
  @override
  _BichosState createState() => _BichosState();
}

class _BichosState extends State<Bichos> {
  final player = AudioPlayer();

  executar(arq) async {
    await player.setSource(AssetSource('audios/' + arq));
    await player.resume();
  }

  @override
  Widget build(BuildContext context) {
    //double largura = MediaQuery.of(context).size.width;
    //double altura = MediaQuery.of(context).size.height;
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.aspectRatio *2,
      children: [
        GestureDetector(
          onTap: () {
            executar('cao.mp3');
          },
          child: Image.asset('assets/images/cao.png'),
        ),
        GestureDetector(
          onTap: () {
            executar('gato.mp3');
          },
          child: Image.asset('assets/images/gato.png'),
        ),
        GestureDetector(
          onTap: () {
            executar('leao.mp3');
          },
          child: Image.asset('assets/images/leao.png'),
        ),
        GestureDetector(
          onTap: () {
            executar('macaco.mp3');
          },
          child: Image.asset('assets/images/macaco.png'),
        ),
        GestureDetector(
          onTap: () {
            executar('ovelha.mp3');
          },
          child: Image.asset('assets/images/ovelha.png'),
        ),
        GestureDetector(
          onTap: () {
            executar('vaca.mp3');
          },
          child: Image.asset('assets/images/vaca.png'),
        )
      ],
    );
  }
}

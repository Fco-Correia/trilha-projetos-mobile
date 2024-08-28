import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube/model/video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyAxzEx1dtclC2IfWTqnWn1WzqDqMBITZdo";
const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {
  Future<List<Video>> pesquisar(String pesquisa) async {
    http.Response response =
        await http.get(Uri.https("www.googleapis.com", "/youtube/v3/search", {
      "part": "snippet",
      "type": "video",
      "maxResults": "20",
      "order": "date",
      "key": CHAVE_YOUTUBE_API,
      "channelId": ID_CANAL,
      "q": pesquisa
    }));

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);
      List<Video> videos = [];
      for (var videoJson in dadosJson["items"]) {
        var id = videoJson['id']['videoId'];
        var titulo = videoJson['snippet']['title'];
        var descricao = videoJson['snippet']['description'];
        var imagem = videoJson['snippet']['thumbnails']['high']['url'];
        var canal = videoJson['snippet']["channelTitle"];
        var video = Video(id: id, titulo: titulo,descricao: descricao, imagem: imagem, canal: canal);
        videos.add(video);
      }

      /*
      for (var video in videos) {
        print(
            "ID: ${video.id}, Título: ${video.titulo}, Imagem: ${video.imagem}, Canal: ${video.canal}");
      }
      */
      return videos;
      /*
      for (int i = 0; i <= 19; i++) {
        print("resultado: " +
            dadosJson["items"][i]["snippet"]["title"].toString());
      }
      */
    } else {
      print("erro");
    }
    return [];
  }
}

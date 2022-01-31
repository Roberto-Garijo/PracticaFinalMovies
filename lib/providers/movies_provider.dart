import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:practica_final_2/models/movie.dart';
import 'package:practica_final_2/models/now_playing_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = 'bd5e8190ec48ff95b2d91b8041d3ac66';
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovies = [];

  MoviesProvider() {
    print('Provider inicialitzat');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
    var url =
        Uri.https(_baseUrl, '3/movie/now_playing', {
          'api_key': _apiKey,
          'language': _language,
          'page': _page
          });

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);
    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }
}

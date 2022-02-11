import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/models/movie.dart';
import 'package:practica_final_2/models/now_playing_response.dart';
import 'package:practica_final_2/models/popular_response.dart';
import 'package:practica_final_2/models/search_movie_response.dart';


//A aquesta classe anirem anant fent peticions als diferents endPoints de l'api de la movieDB.
//Construirem una url depenguent del resultat que volguem obtenir de l'api
class MoviesProvider extends ChangeNotifier {
//Declaram una serie de constants que emplearem a la petició de l'api
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = 'bd5e8190ec48ff95b2d91b8041d3ac66';
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> casting = {};

//Depenguent del metode que empleam feim una petició o un altre
  MoviesProvider() {
    print('Provider inicialitzat');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);
    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    print('getPopularMovies');
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final popularResponse = PopularResponse.fromJson(result.body);
    popularMovies = popularResponse.results;

    notifyListeners();
  }
//Els dos darrers metodes retornam una future list de cast i de les search movie
  Future<List<Cast>> getMovieCast(int idMovie) async {
    var url = Uri.https(_baseUrl, '3/movie/$idMovie/credits',
        {'api_key': _apiKey, 'language': _language, 'page': _page});
    final result = await http.get(url);
    final creditsResponse = CreditsResponse.fromJson(result.body);

    casting[idMovie] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> getOnDisplaySearch(String query) async {
    print('getOnDisplayPopularMovies');
    var url = Uri.https(_baseUrl, '/3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final result = await http.get(url);

    final searchResponse = SearchResponse.fromJson(result.body);

    return searchResponse.results;
  }
}

import 'package:flutter/material.dart';
import 'package:practica_final_2/models/movie.dart';
import 'package:practica_final_2/providers/movies_provider.dart';
import 'package:practica_final_2/widgets/card_swiper.dart';
import 'package:provider/provider.dart';

class SearchBar extends SearchDelegate<String> {
  final List<Movie> movie;
  SearchBar(this.movie);

  //Aquesta pantalla s'obre quan pitjam els botó de la 'llupa' a la home screen. 
  //quan feim una clase que extends a searchDelegate hem de fer 4 override amb metodes que realitzen diferents accions

  //El primer botó esborra tot el texte introduit per cercar pelis
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

//Aquest boto mostra els resultats donats quan l'usuari pitja 'ENTER'
//Primer mostra els resultats de la llista de pelis populars quan el texte introduit es null
//En el moment en que l'usuari introdueix texte es fa la peticio a l'api i mentre que es carreguen els resultats
//es mostra una petita 'pantalla de carrega'.
//En el moment que carrega totes les dates va introduint tot a un ListView
  @override
  Widget buildResults(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final sampleMovies = movie
        .where((movie) =>
            movie.title.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    if (query.isEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () => Navigator.pushNamed(context, 'details',
              arguments: sampleMovies[index]),
          leading: Image(
              image: NetworkImage(sampleMovies[index].fullPosterPath)),
          title: Text(sampleMovies[index].title),
        ),
        itemCount: sampleMovies.length,
      );
    } else {
      return FutureBuilder(
          future: moviesProvider.getOnDisplaySearch(query),
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              final movies = snapshot.data!;
              return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  onTap: () => Navigator.pushNamed(context, 'details',
                      arguments: movies![index]),
                  leading: Image(
                    image: NetworkImage(movies![index].fullPosterPath),
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                  title: Text(movies[index].title),
                ),
                itemCount: movies.length,
              );
            }
          });
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final sampleMovies = movie
        .where((movie) =>
            movie.title.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    if (query.isEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () => Navigator.pushNamed(context, 'details',
              arguments: sampleMovies[index]),
          leading: Image(
              image: NetworkImage(sampleMovies[index].fullPosterPath)),
          title: Text(sampleMovies[index].title),
        ),
        itemCount: sampleMovies.length,
      );
    } else {
      return FutureBuilder(
          future: moviesProvider.getOnDisplaySearch(query),
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              final movies = snapshot.data!;
              return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  onTap: () => Navigator.pushNamed(context, 'details',
                      arguments: movies![index]),
                  leading: Image(
                    image: NetworkImage(movies![index].fullPosterPath),
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                  title: Text(movies[index].title),
                ),
                itemCount: movies.length,
              );
            }
          });
    }
  }
}

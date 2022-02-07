import 'package:flutter/material.dart';
import 'package:practica_final_2/models/movie.dart';
import 'package:practica_final_2/providers/movies_provider.dart';
import 'package:practica_final_2/widgets/card_swiper.dart';
import 'package:provider/provider.dart';

class SearchBar extends SearchDelegate<String> {
  final List<Movie> movie;
  SearchBar(this.movie);

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

  @override
  Widget buildResults(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final listaSugerencias = movie
        .where((movie) =>
            movie.title.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    if (query.isEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () => Navigator.pushNamed(context, 'details',
              arguments: listaSugerencias[index]),
          leading: Image(
              image: NetworkImage(listaSugerencias[index].fullPosterPath)),
          title: Text(listaSugerencias[index].title),
        ),
        itemCount: listaSugerencias.length,
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
    final listaSugerencias = movie
        .where((movie) =>
            movie.title.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    if (query.isEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () => Navigator.pushNamed(context, 'details',
              arguments: listaSugerencias[index]),
          leading: Image(
              image: NetworkImage(listaSugerencias[index].fullPosterPath)),
          title: Text(listaSugerencias[index].title),
        ),
        itemCount: listaSugerencias.length,
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

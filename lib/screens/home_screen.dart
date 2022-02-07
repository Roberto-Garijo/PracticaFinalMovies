import 'package:flutter/material.dart';
import 'package:practica_final_2/providers/movies_provider.dart';
import 'package:practica_final_2/screens/search_bar.dart';
import 'package:practica_final_2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);
    print(moviesProvider.onDisplayMovies);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(111, 148, 254, 100),
        title: Text('Cartellera'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchBar(moviesProvider.popularMovies));
            },
            icon: Icon(Icons.search_outlined)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            
            children: [

              // Targetes principals
              CardSwiper(movies: moviesProvider.onDisplayMovies),
              
              // Slider de pel·licules
              MovieSlider(movies: moviesProvider.popularMovies),
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
              // MovieSlider(),
              // MovieSlider(),

            ],
          ),
        )
      )
    );
  }
}

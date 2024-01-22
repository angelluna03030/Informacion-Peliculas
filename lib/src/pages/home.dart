// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/providers_peliculas.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/Card_horizontal.dart';

import 'package:peliculas/src/widgets/swiperTargetas_widget.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    // ignore: prefer_const_constructors
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Peliculas en cines"),
          backgroundColor: const Color.fromARGB(255, 40, 120, 240),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch(),
                 );
                }),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_swiperTargetas(), _footer(context)],
          ),
        ));
  }

  Widget _swiperTargetas() {
    return FutureBuilder<List<Pelicula>>(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error al cargar las películas: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No se encontraron películas'),
          );
        } else {
          return CardSwiper(peliculas: snapshot.data!);
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Populares",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          Center(
            child: StreamBuilder(
              stream: peliculasProvider.popularesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Pelicula>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No se encontraron películas populares'));
                } else {
                  return CardHorizontal(
                    peliculas: snapshot.data!,
                    SiguinetePagina: peliculasProvider.getPopulares,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/providers_peliculas.dart';

//hay que implemetarlas todas.
class DataSearch extends SearchDelegate {
  final peliculaProvider = PeliculasProvider();

  @override
  List<Widget>? buildActions(BuildContext context) {
    //las acciones de nuestro AppBard, o un icono.
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //Icono a la izquier de AppBard, o para regresarse.
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Crea los resultados que vamos a mostrar.
    return Center(
      child: Container(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // son las sugerencias que aparecen cuando la persona escribe.

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculaProvider.buscarPelicula(query),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data!;

          return ListView(
            children: peliculas.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: const AssetImage(
                      "assets/img/icon-image-not-found-free-vector.jpg"),
                  width: 60.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  close(context, null);

                  Navigator.pushNamed(
                    context,
                    'detalle',
                    arguments: pelicula,
                  );
                
                },
              );
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

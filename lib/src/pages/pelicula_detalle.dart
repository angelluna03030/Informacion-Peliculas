import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

import 'package:peliculas/src/providers/providers_peliculas.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: use_key_in_widget_constructors
class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula? pelicula =
        ModalRoute.of(context)?.settings.arguments as Pelicula?;

    if (pelicula == null) {
      // Manejar el caso en el que el valor es nulo
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body:  const Center(
          child: Text('Error: Película no encontrada'),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 400.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    pelicula.title,
                    style:  const TextStyle(color: Colors.black),
                  )),
              background: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(
                  pelicula.getImgaesId(),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _crearInfoPelicula(pelicula),
                _crearOverview(pelicula),
                _crearOverview(pelicula),
                _crearOverview(pelicula),
                _crearBotonTrailer(context, pelicula),
                _actores(),
                _crearCastin(pelicula)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearInfoPelicula(Pelicula pelicula) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Título: ${pelicula.title}',
            style:const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        const   SizedBox(height: 8.0),
          Text(
      'Fecha de lanzamiento: ${_formatFecha(pelicula.releaseDate)}',
            style:  const TextStyle(fontSize: 16.0),
          ),
        const  SizedBox(height: 8.0),
          Row(
            children: [
          const    Icon(Icons.star_border),
              Text(
     ' ${pelicula.voteAverage.toStringAsFixed(1)}',

                style:const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
      const    SizedBox(height: 8.0),
        ],
      ),
    );
  }
String _formatFecha(DateTime fecha) {
  // Formatea la fecha en el formato deseado (día, mes y año)
  return '${fecha.day}/${fecha.month}/${fecha.year}';
}
  Widget _crearOverview(Pelicula pelicula) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Sinopsis:\n${pelicula.overview}',
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget _crearBotonTrailer(BuildContext context, Pelicula pelicula) {
    return Container(
      padding:const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {
          _abrirYouTubeConBusqueda(context, pelicula.title);
        },
        child: const Text('Ver Tráiler'),
      ),
    );
  }

Widget _actores() {
  return const Center(
    child: SizedBox(
      height: 40,
      child:  Text(
        "Actores",
        style: TextStyle(fontSize: 20.0),
      ),
    ),
  );
}

  Future<void> _abrirYouTubeConBusqueda(
      BuildContext context, String titulo) async {
    final uri = Uri.parse(
        'https://www.youtube.com/results?search_query=trailer+de+$titulo');
    try {
      await launchUrl(uri);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No se pudo abrir el enlace a YouTube.'),
      ));
    }
  }

  Widget _crearCastin(Pelicula pelicula) {
    final peliProvider = PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          List<Actor> actores = snapshot.data!;
          
          
          return _creaActoresPageView(actores);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _creaActoresPageView(List<Actor>? actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: actores?.length ?? 0,
        itemBuilder: (context, i) {
          return Text(actores?[i].name ?? '');
        },
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
      ),
    );
  }

  // ignore: non_constant_identifier_names, unused_element
  Widget _TargetaDelActor(Actor actor) {
    return Column(
      children: <Widget>[
        FadeInImage(
            placeholder:
            const    AssetImage("assets/img/icon-image-not-found-free-vector.jpg"),
            image: actor.getFoto())
      ],
    );
  }
}

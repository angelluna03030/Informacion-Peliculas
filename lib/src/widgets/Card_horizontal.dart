// ignore_for_file: file_names

import "package:flutter/material.dart";
import 'package:peliculas/src/models/pelicula_model.dart';

class CardHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  // ignore: non_constant_identifier_names
  final Function SiguinetePagina;

  CardHorizontal({
    Key? key,
    required this.peliculas,
    // ignore: non_constant_identifier_names
    required this.SiguinetePagina,
  }) : super(key: key);

  final _pageController =
      PageController(initialPage: 1, viewportFraction: 0.34);

  @override
  Widget build(BuildContext context) {
    final  screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        SiguinetePagina();
      }
    });

    // ignore: sized_box_for_whitespace
    return Container(
      height: screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) {
          return crearTarjeta(context, peliculas[i]);
        },
      ),
    );
  }

  Widget crearTarjeta(BuildContext context, Pelicula pelicula) {
    // ignore: non_constant_identifier_names
    final PeliculaTargeta = Container(
      margin: const EdgeInsets.only(right: 25.0),
      width: 160.0, // Ajusta el ancho según sea necesario
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              placeholder: const AssetImage(
                  'assets/img/icon-image-not-found-free-vector.jpg'),
              image: NetworkImage(pelicula.getPosterImg()),
              fit: BoxFit.fill,
              height: 170.0,
            ),
          ),
          const SizedBox(
            height: 2.5,
          ), // Espacio adicional entre la imagen y el texto
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2, // Limita a 2 líneas para evitar desbordamiento
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
    return GestureDetector(
      child: PeliculaTargeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }
}

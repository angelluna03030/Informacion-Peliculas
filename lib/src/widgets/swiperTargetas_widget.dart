// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_swipe/flutter_swipe.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/pages/pelicula_detalle.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  const CardSwiper({required this.peliculas});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemHeight: _screenSize.height * 0.5,
        itemWidth: _screenSize.width * 0.7,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return Hero(
            tag: peliculas[index].id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PeliculaDetalle(),
    settings: RouteSettings(
      arguments: peliculas[index],
    ),
  ),
),
                child: FadeInImage(
                  image: NetworkImage( peliculas[index].getPosterImg()),
                  placeholder: const AssetImage("assets/img/icon-image-not-found-free-vector.jpg"),
                fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: peliculas.length,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/home.dart';
import 'package:peliculas/src/pages/pelicula_detalle.dart';



void main() {
  
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Peliculas",
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) =>  HomePage(),
        'detalle' :(BuildContext context) => PeliculaDetalle(),
          
        
      },
    );
  }
}

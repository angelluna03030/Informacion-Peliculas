import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  final String _apiKey = 'a090ee15eebc0477862319db5a85bd06';
  final String _url = 'api.themoviedb.org';
  final String _language = "es-ES";
  int _popularesPage = 0;
  bool _cargando = false;

  final List<Pelicula> _populares = [];

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStream() {
    _popularesStreamController.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Pelicula> peliculas = List.from(data['results'].map((p) {
          try {
            return Pelicula.fromJsonMap(p);
          } catch (e) {
            return null;
          }
        }));

        // ignore: unnecessary_null_comparison
        peliculas.removeWhere((p) => p == null);

        return peliculas;
      } else {
        throw Exception('Error al cargar las películas');
      }
    } catch (error) {
      throw Exception('Error al conectar con el servidor: $error');
    }
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, "/3/movie/now_playing",
        {'api_key': _apiKey, 'language': _language});
    return _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, "/3/movie/popular", {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });
    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }

Future<List<Actor>> getCast(String peliId) async {
  final url = Uri.https(_url, "3/movie/$peliId/credits",
      {'api_key': _apiKey, 'language': _language});
  
  try {
    final resp = await http.get(url);
    
    if (resp.statusCode == 200) {
      final decoData = json.decode(resp.body);
      
   

      final dynamic castData = decoData["cast"];


      final cast = castData is List ? Cast.fromJsonList(castData) : null;

      if (cast != null) {
        return cast.actores;
      } else {
        return [];
      }
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}


  Future<List<Pelicula>> buscarPelicula( String query) async {
    final url = Uri.https(_url, "3/search/movie",
        {'api_key': _apiKey, 'language': _language, 'query': query});
    return _procesarRespuesta(url);
  }


}

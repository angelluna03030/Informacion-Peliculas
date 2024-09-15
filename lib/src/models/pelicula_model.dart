class Peliculas {
  List<Pelicula> items = [];

  Peliculas();

  Peliculas.fromJson(List<dynamic>? jsonList) {
    if (jsonList == null) return;

    items = jsonList.map((item) => Pelicula.fromJsonMap(item)).toList();
  }
}

class Pelicula {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Pelicula({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json)
      : adult = json["adult"] ?? false,
        backdropPath = json["backdrop_path"] ?? "",
        genreIds = (json["genre_ids"] as List<dynamic>?)?.cast<int>() ?? [],
        id = json["id"] ?? 0,
        originalLanguage = json["original_language"] ?? "",
        originalTitle = json["original_title"] ?? "",
        overview = json["overview"] ?? "",
        popularity = (json["popularity"] as num?)?.toDouble() ?? 0.0,
        posterPath = json["poster_path"] ?? "",
        releaseDate = DateTime.tryParse(json['release_date'] ?? '') ?? DateTime.now(),
        title = json["title"] ?? "",
        video = json["video"] ?? false,
        voteAverage = (json["vote_average"] as num?)?.toDouble() ?? 0.0,
        voteCount = json["vote_count"] ?? 0;

  getPosterImg() {
// ignore: unnecessary_null_comparison
if (posterPath == null ){
return "https://static.vecteezy.com/system/resources/previews/004/1+41/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg";
}

    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  getImgaesId() {
// ignore: unnecessary_null_comparison
if (posterPath == null ){
return "https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg";
}

    return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }

 
}

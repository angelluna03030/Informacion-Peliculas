// ignore_for_file: unnecessary_null_comparison, constant_identifier_names

class Cast {
  List<Actor> actores = [];
  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    // ignore: avoid_function_literals_in_foreach_calls
    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}

class Actor {
  late bool adult;
  late int gender;
  late int id;
  late String knownForDepartment;
  late String name;
  late String originalName;
  late double popularity;
  late String profilePath;
  late int castId;
  late String character;
  late String creditId;
  late int order;
  late String department;
  late String job;

  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    required this.department,
    required this.job,
  });
  Actor.fromJsonMap(Map<String, dynamic> json) {
    adult = json["adult"] ?? false;
    gender = json["gender"] ?? 0;
    id = json["id"] ?? 0;
    knownForDepartment = json["known_for_department"] ?? "";
    name = json["name"] ?? "";
    originalName = json["original_name"] ?? "";
    popularity = json["popularity"] ?? 0.0;
    profilePath = json["profile_path"] ?? "";
    castId = json["cast_id"] ?? 0;
    character = json["character"] ?? "";
    creditId = json["credit_id"] ?? "";
    order = json["order"] ?? 0;
    department = json["department"] ?? "";
    job = json["job"] ?? "";
  }
  getFoto() {
    if (id == null) {

      return "https://www.slotcharter.net/wp-content/uploads/2020/02/no-avatar.png";
    } else {
    
      return 'https://api.themoviedb.org/3/person/$id/images';
    }
  }
}

enum Department {

  ACTING,
  WRITING,
  CREW,
  VISUAL_EFFECTS,
  DIRECTING,
  PRODUCTION,
  COSTUME_MAKE_UP,
  ART,
  SOUND,
  CAMERA,
  EDITING,
  LIGHTING
}

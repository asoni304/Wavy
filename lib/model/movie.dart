import 'package:get_it/get_it.dart';
import 'package:wavy/model/app_config.dart';

class Movie{
  late final String  name;
  late final String  language;
  late final String  description;
  late bool isAdult;
  late final String  posterPath;
  late final String  backdropPath;
  late final num  rating;
  late final String  releaseDate;

  Movie({required this.name,required this.backdropPath,required this.description,required this.isAdult,required this.language,required this.posterPath,required this.rating,required this.releaseDate});
factory Movie.fromJson(Map<String,dynamic>_json){
return Movie(
    language: _json['original_language'],
    backdropPath: _json['backdrop_path'],
    releaseDate: _json['release_date'],
    rating: _json['vote_average'],
    name: _json['original_title'],
    posterPath: _json['poster_path'],
    isAdult: _json['adult'],
    description: _json['overview']
);
}
String posterURL(){
  final AppConfig _appConfig = GetIt.instance.get<AppConfig>();
  return '${_appConfig.BASE_API_URL}${this.posterPath}';
}
}
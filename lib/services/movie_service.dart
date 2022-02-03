import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wavy/model/movie.dart';
import 'package:wavy/services/http_service.dart' ;
import 'package:http/http.dart' as http;







class MovieService{


Future <MovieResponse> getPopularMovies ()async {
  final finalUrl=Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=d7f2f452bc47842b08ab1e830e34084c&language=en-US&page=1');
  var response=await http.get(finalUrl);
  var jsonResponse=jsonDecode(response.body);
  return MovieResponse.fromJson(jsonResponse);

}
Future <MovieResponse> getUpComingMovies ()async {
  final finalUrl=Uri.parse('https://api.themoviedb.org/3/movie/upcoming?api_key=d7f2f452bc47842b08ab1e830e34084c&language=en-US&page=1');
  var response=await http.get(finalUrl);
  var jsonResponse=jsonDecode(response.body);
  return MovieResponse.fromJson(jsonResponse);

}
Future <MovieResponse> getTopRatedMovies ()async {
  final finalUrl=Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=d7f2f452bc47842b08ab1e830e34084c&language=en-US&page=1');
  var response=await http.get(finalUrl);
  var jsonResponse=jsonDecode(response.body);
  return MovieResponse.fromJson(jsonResponse);

}
Future <MovieResponse> getLatestMovies ()async {
  final finalUrl=Uri.parse('https://api.themoviedb.org/3/movie/latest?api_key=d7f2f452bc47842b08ab1e830e34084c&language=en-US&page=1');
  var response=await http.get(finalUrl);
  var jsonResponse=jsonDecode(response.body);
  return MovieResponse.fromJson(jsonResponse);

}
Future <MovieResponse> getNowPlayingMovies ()async {
  final finalUrl=Uri.parse('https://api.themoviedb.org/3/movie/now_playing?api_key=d7f2f452bc47842b08ab1e830e34084c&language=en-US&page=1');
  var response=await http.get(finalUrl);
  var jsonResponse=jsonDecode(response.body);
  return MovieResponse.fromJson(jsonResponse);

}
Future <MovieResponse> searchMovies (String )async {
  final finalUrl=Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=d7f2f452bc47842b08ab1e830e34084c&language=en-US&page=1');
  var response=await http.get(finalUrl);
  var jsonResponse=jsonDecode(response.body);
  return MovieResponse.fromJson(jsonResponse);

}
}
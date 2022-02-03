import 'package:rxdart/rxdart.dart';
import 'package:wavy/model/movie.dart';
import 'package:wavy/services/movie_service.dart';
import '../model/search_category.dart';

final moviesBloc=MoviesBloc();

class MoviesBloc{

  final MovieService _movieService=MovieService();
  final BehaviorSubject<MovieResponse> _subject=BehaviorSubject<MovieResponse>();


  getMovies() async{
    var response=await _movieService.getNowPlayingMovies();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject=>_subject;

   updateSearchCategory( _category) async {

     if(_category==SearchCategory.popular) {
       try {
         var response = await _movieService.getPopularMovies();
         _subject.sink.add(response);
         _category=SearchCategory.popular;
       }
       catch (e) {
         print(e);
       }
     }
     else if(_category==SearchCategory.topRated) {
       try {
         var response = await _movieService.getTopRatedMovies();
         _subject.sink.add(response);
         _category=SearchCategory.topRated;
       }
       catch (e) {
         print(e);
       }
     }
     else if(_category==SearchCategory.nowPlaying) {
       try {
         var response = await _movieService.getNowPlayingMovies();
         _subject.sink.add(response);
         _category=SearchCategory.nowPlaying;
       }
       catch (e) {
         print(e);
       }
     }
     else if(_category==SearchCategory.latest) {
       try {
         var response = await _movieService.getLatestMovies();
         _subject.sink.add(response);
         _category=SearchCategory.latest;
       }
       catch (e) {
         print(e);
       }
     }
     else if(_category==SearchCategory.upcoming){
       var response = await _movieService.getUpComingMovies();
       _subject.sink.add(response);
       _category=SearchCategory.upcoming;
     }


  }
updateTextSearch(String _searchText) async {
try{
  var response = await _movieService.searchMovies(String);
  _subject.sink.add(response);
}
catch(e){
  print(e);
}

  }




}
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../model/movie.dart';
class MovieTile extends StatelessWidget {

  final GetIt _getIt =GetIt.instance;

  final double height;
  final double width;
  final Movie movie;

  MovieTile({Key? key,  required this.height,required this.width,required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _moviePoster(movie.posterURL()),
          _movieInfo(),
        ],
      ),
    );
  }
Widget _moviePoster(String _imageUrl){
    return Container(
      height: height,
      width: width*0.35,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(_imageUrl))
      ),
    );
}
Widget _movieInfo(){
    return Container(
      height: height,
      width: width*0.66,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Row(
           mainAxisSize: MainAxisSize.max,
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Container(
               width: width*0.56,
               child: Text(movie.name,overflow: TextOverflow.ellipsis,style: const TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w400),),
             ),
             Text(movie.rating.toString(),style: const TextStyle(color: Colors.white,fontSize: 22),),

           ],
         ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height*0.003, 0, 0),
            child: Text('${movie.language.toUpperCase()} | R: ${movie.isAdult} | ${movie.releaseDate}',
              style: const TextStyle(color: Colors.white,fontSize: 12,),),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height*0.003, 0, 0),
            child: Text(movie.description,maxLines: 4,overflow: TextOverflow.ellipsis,style: const TextStyle(color: Colors.white70,fontSize: 10),),
          )
        ],
      ),
    );
}

}

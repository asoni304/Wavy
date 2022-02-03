import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wavy/bloc/moviesBloc.dart';

import 'package:wavy/model/movie.dart';
import '../widgets/movie_tile.dart';
import '../model/search_category.dart';
import '../model/movie.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
   late double _deviceHeight;
   late double _deviceWidth;
   late TextEditingController _searchTextFieldController;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesBloc.getMovies();
  }
  @override
  Widget build(BuildContext context) {
    _deviceWidth= MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;
    _searchTextFieldController=TextEditingController();

    return _buildUI();

  }
  Widget _buildUI(){

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body:Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          children: [
            _backgroundWidget(),
            _foregroundWidget(),

          ],
        ),
      ) ,
    );
  }
   Widget _backgroundWidget(){
     return Container(
       height: _deviceHeight,
       width: _deviceWidth,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10.0),
         image: const DecorationImage(
           image: NetworkImage('https://wallpapercave.com/wp/wp9920342.jpg',),
           fit: BoxFit.cover,
         ),
       ),
       child: BackdropFilter(
         filter: ImageFilter.blur(sigmaX: 15.0,sigmaY: 15.0 ),
         child: Container(
           decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
         ),

       ),


     );
   }
   Widget _foregroundWidget(){
     return Container(
       margin: const EdgeInsets.only(left: 10,right: 10),
       padding: EdgeInsets.fromLTRB(0, _deviceHeight*0.02, 0, 0),
       child: Column(
         mainAxisSize: MainAxisSize.max,
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.end,
         children: [
           _topBar(),
           Container(
             height: _deviceHeight*0.83,
             padding: EdgeInsets.symmetric(vertical: _deviceHeight*0.01),
             child: _moviesListViewWidget(),
           ),


         ],
       ),
     );
   }

   Widget _topBar(){
     return Container(
       height: _deviceHeight*0.08,
       decoration: BoxDecoration(
           color: Colors.black54,
           borderRadius: BorderRadius.circular(20.0)
       ),
       child: Row(
         mainAxisSize: MainAxisSize.max,
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           _searchButton(),
           _searchField(),

           _categorySelection(),
         ],
       ),
     );
   }
   Widget _searchButton(){
    return IconButton(onPressed:() {}, icon: Icon(Icons.search,color: Colors.white24,));
   }



   Widget _searchField(){
     const  _border=InputBorder.none;
     return Container(
       width: _deviceWidth*0.5,
       height: _deviceHeight*0.05,
       child: TextField(
         controller: _searchTextFieldController,
         onSubmitted: (_input){},
         style: const TextStyle(color: Colors.white,),
         decoration: const InputDecoration(
             focusedBorder: _border,

             // prefixIcon: Icon(Icons.search,color: Colors.white24,),
             hintStyle: TextStyle(color: Colors.white54,),
             filled: false,
             fillColor: Colors.white54,
             hintText: 'Search...'
         ),
       ),
     );
   }
   Widget _categorySelection(){

     return StreamBuilder(
         stream: moviesBloc.subject.stream,
         builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
       return DropdownButton(
         onChanged: (value)=>value.toString().isNotEmpty?moviesBloc.updateSearchCategory(value):null,

         dropdownColor: Colors.black38,
         value:SearchCategory.nowPlaying,
         icon: const Icon(Icons.menu,color: Colors.white24,
         ),
         underline: Container(height: 1,color: Colors.white24,),

         items: const [
           DropdownMenuItem(
             value:SearchCategory.popular,
             child: Text(SearchCategory.popular,style: TextStyle(color: Colors.white24),),),
           DropdownMenuItem(
             value:SearchCategory.upcoming,
             child: Text(SearchCategory.upcoming,style: TextStyle(color: Colors.white24),),),
           DropdownMenuItem(
             value:SearchCategory.latest,
             child: Text(SearchCategory.latest,style: TextStyle(color: Colors.white24),),),
           DropdownMenuItem(
             value:SearchCategory.nowPlaying,
             child: Text(SearchCategory.nowPlaying,style: TextStyle(color: Colors.white24),),),
           DropdownMenuItem(
             value:SearchCategory.topRated,
             child: Text(SearchCategory.topRated,style: TextStyle(color: Colors.white24),),),



         ],
       );}
     );
   }
   Widget _moviesListViewWidget() {
     return StreamBuilder(
       stream: moviesBloc.subject.stream,
       builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
         return Container(
            margin: const EdgeInsets.only(top: 20, left: 0, right: 0, bottom: 10),
           child: ListView.builder(
               itemCount: snapshot.data!.movies.length,
               itemBuilder: (context, index) {
                 return Padding(padding: const EdgeInsets.all(5),
                   child: Container(
                     child: Row(
                       mainAxisSize: MainAxisSize.max,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           height: _deviceHeight*0.25,
                           width: _deviceWidth*0.30,
                           decoration: BoxDecoration(
                               image: DecorationImage(image: NetworkImage('https://image.tmdb.org/t/p/w500' + snapshot.data!.movies[index].posterPath))
                           ),
                         ),

                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(
                             height: _deviceHeight*0.20,
                             width:_deviceWidth*0.50,
                             child: Column(
                               mainAxisSize: MainAxisSize.max,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Row(
                                   mainAxisSize: MainAxisSize.min,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Container(
                                       width: _deviceWidth*0.40,
                                       child: Text(snapshot.data!.movies[index].name,overflow: TextOverflow.ellipsis,style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                                     ),
                                     Text(snapshot.data!.movies[index].rating.toString(),style: const TextStyle(color: Colors.white,fontSize: 22),),

                                   ],
                                 ),
                                 Container(
                                    padding: EdgeInsets.fromLTRB(0, _deviceHeight*0.0002, 0, 0),
                                   child: Text('${snapshot.data!.movies[index].language.toUpperCase()} | R: ${snapshot.data!.movies[index].isAdult} | ${snapshot.data!.movies[index].releaseDate}',
                                     style: const TextStyle(color: Colors.white,fontSize: 12,),),
                                 ),
                                 Container(
                                    padding: EdgeInsets.fromLTRB(0, _deviceHeight*0.02, 0, 0),
                                   child: Text(snapshot.data!.movies[index].description,maxLines: 3,overflow: TextOverflow.ellipsis,style: const TextStyle(color: Colors.white70,fontSize: 14),),
                                 )
                               ],
                             ),
                           ),
                         ),
                       ],
                     ),
                   )

                 );
               }
           ),
         );
       },
     );

   }



}

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wavy/model/movie.dart';
import '../model/search_category.dart';

class MainPage extends ConsumerWidget{
  late double _deviceHeight;
  late double _deviceWidth;
  late TextEditingController _searchTextFieldController;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    _deviceHeight=MediaQuery.of(context).size.height;
    _deviceWidth=MediaQuery.of(context).size.width;
    _searchTextFieldController=TextEditingController();
    return _buildUI();

  }
  Widget _buildUI(){
    return Scaffold(
backgroundColor: Colors.black,
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
             _backgroundWidget(),
            _foregroundWidget(),

          ],
        ),
      ),
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
      padding: EdgeInsets.fromLTRB(0, _deviceHeight*0.02, 0, 0),
      width: _deviceWidth*0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
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
          _searchField(),
          _categorySelection(),
        ],
      ),
    );
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
            prefixIcon: Icon(Icons.search,color: Colors.white24,),
          hintStyle: TextStyle(color: Colors.white54,),
          filled: false,
          fillColor: Colors.white54,
          hintText: 'Search...'
        ),
      ),
    );
  }
  Widget _categorySelection(){
    return DropdownButton(
      onChanged: (value){},
        dropdownColor: Colors.black38,
        value:SearchCategory.popular,
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
          value:SearchCategory.top10,
          child: Text(SearchCategory.top10,style: TextStyle(color: Colors.white24),),),
        DropdownMenuItem(
          value:SearchCategory.throwback,
          child: Text(SearchCategory.throwback,style: TextStyle(color: Colors.white24),),),
        DropdownMenuItem(
          value:SearchCategory.none,
          child: Text(SearchCategory.none,style: TextStyle(color: Colors.white24),),),



      ],
    );
  }
  Widget _moviesListViewWidget(){
    final List <Movie>_movies=[];
for(var i=0;i<20;i++){
_movies.add(Movie(name: 'Mko', backdropPath: '/4ynQYtSEuU5hyipcGkfD6ncwtwz.jpg', description: 'The sourcerer from OZ returns seeking revenge for his dead father only to find out that his mother was the killer', isAdult: false, language: 'EN', posterPath:'/IfB9hy4JH1eH6HEfIgIGORXi5h.jpg', rating: 8, releaseDate: '12/06/2020'));
}


    if(_movies.length!=0){
   return ListView.builder(
     itemCount: _movies.length,
     itemBuilder: (BuildContext _context,int _count){
       return Padding(
         padding: EdgeInsets.symmetric(vertical: _deviceHeight*0.01),
         child: GestureDetector(
           onTap: (){},
           child: Text(_movies[_count].name,style: TextStyle(
             fontSize: 23,
             fontWeight: FontWeight.bold,
           ),),
         ),
       );
     },);
    }
    else{
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}
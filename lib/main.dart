import 'package:flutter/material.dart';
import 'package:wavy/pages/main_page.dart';
import './pages/splash_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    SplashPage(
      key:UniqueKey(),
      onInitializationComplete: ()=>runApp(
          ProviderScope(child:  MyApp()),
          ),
    ),

  );
}
 class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       title: 'Wavy',
       initialRoute: 'home',
       routes: {
         'home':(BuildContext _context)=>MainPage()
       },
       theme: ThemeData(
         primarySwatch: Colors.indigo,
         visualDensity: VisualDensity.adaptivePlatformDensity
       ),
     );
   }
 }


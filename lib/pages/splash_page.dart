import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:wavy/services/http_service.dart';
import 'package:wavy/services/movie_service.dart';
import '../model/app_config.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashPage({Key? key, required this.onInitializationComplete}) : super(key: key);



  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {

    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((_) => _setup(context).then((_) => widget.onInitializationComplete()));
// _setup(context).then((_) => widget.onInitializationComplete());
  }

  Future <void> _setup(BuildContext _context) async{
final getIt= GetIt.instance;

final configFile= await rootBundle.loadString('assets/config/main.json');
final configData = jsonDecode(configFile);

getIt.registerSingleton<AppConfig>(
    AppConfig(
        BASE_API_URL:configData['BASE_API_URL'],
        BASE_IMAGE_API_URL: configData['BASE_IMAGE_API_URL'],
        API_KEY: configData['API_KEY']),

);
getIt.registerSingleton<HTTPService>(
    HTTPService(),
);
getIt.registerSingleton<MovieService>(
  MovieService(),
);

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wavy',
      theme: ThemeData(
        primarySwatch: Colors.indigo,

      ),
      home: Center(
        child: Container(
          height:300,
          width:300,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/wavy.png')
            )
          ),
        ),
      ),
    );
  }
}

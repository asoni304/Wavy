import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../model/app_config.dart';

class HTTPService{
final Dio dio =Dio();
final GetIt getIt= GetIt.instance;

late String _base_url;
late String _api_key;

HTTP(){
  AppConfig _config= getIt.get<AppConfig>();
  _base_url=_config.BASE_API_URL;
  _api_key=_config.API_KEY;
}

Future<Response> (String _path,{required Map<String,dynamic>query})async{
try{
  // 'google.com/movie/popular'
String _url= '$_base_url$_path';
Map<String,dynamic>_query={
  'api_key':_api_key,
  'language':'en-us',


};
if(query!= null){
  _query.addAll(query);
}
return await dio.get(_url,queryParameters: _query );
}
on DioError catch(e){
print('Unable to perform get request ');
print('DioError:$e ');
}
}

}
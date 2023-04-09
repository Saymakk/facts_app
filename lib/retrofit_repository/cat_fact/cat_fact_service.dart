import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'cat_fact_service.g.dart';

@RestApi(baseUrl: "https://catfact.ninja/")
abstract class CatFactService {
  factory CatFactService(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/fact")
  Future<dynamic> getFact();
}

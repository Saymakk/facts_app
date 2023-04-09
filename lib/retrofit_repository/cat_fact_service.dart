import 'package:facts_app/models/cat_fact_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'cat_fact_service.g.dart';

@RestApi(baseUrl: "https://catfact.ninja/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/fact")
  Future<dynamic> getFact();
}

@JsonSerializable()
class CatFact {
  String? fact;


  CatFact({this.fact});

  factory CatFact.fromJson(Map<String, dynamic> json) => _$CatFactFromJson(json);
  Map<String, dynamic> toJson() => _$CatFactToJson(this);
}
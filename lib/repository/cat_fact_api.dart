import 'package:dio/dio.dart';
import 'package:facts_app/repository/abstract_api.dart';
import 'package:flutter/foundation.dart';

class FactApiRepository implements AbstractFactsApi {

  @override
  Future<String> fetchFact() async {
    final Dio dio = Dio();
    const String url = 'https://catfact.ninja/fact?max_length=140';
    Response response = await dio.get(url);
    final data = response.data['fact'] as String;
    debugPrint(data.toString());
    return data;
  }
}

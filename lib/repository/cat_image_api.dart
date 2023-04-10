import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class CatImageProvider {
  Future<dynamic> loadImage() async {
    try {
      final response = await Dio().get(
        'https://cataas.com/cat',
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      final bytes = response.data;
      dynamic imageProvider = MemoryImage(bytes);
      return imageProvider;
    } catch (e) {
      print('Error loading image: $e');
    }
  }
}

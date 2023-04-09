import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../../repository/cat_image_api.dart';

part 'cat_image_state.dart';

class CatImageCubit extends Cubit<CatImageState> {
  CatImageCubit() : super(CatImageInitial());

  Future<void> fetchImage() async {
    final dio = Dio();
    emit(CatImageLoading());
    try {
      print("LOADING IMAGE....");
      final image = await CatImageProvider().loadImage();
      emit(CatImageLoaded(image));
    } catch (e) {
      emit(CatImageError('Failed to fetch image'));
    }
  }
}

part of 'cat_image_cubit.dart';

@immutable
abstract class CatImageState {}

class CatImageInitial extends CatImageState {}
class CatImageLoading extends CatImageState {}
class CatImageLoaded extends CatImageState {
  final MemoryImage image;

  CatImageLoaded(this.image);
}
class CatImageError extends CatImageState {
  final String message;

  CatImageError(this.message);
}

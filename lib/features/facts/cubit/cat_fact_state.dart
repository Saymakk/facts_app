part of 'cat_fact_cubit.dart';

@immutable
abstract class CatFactState {}

class CatFactInitial extends CatFactState {}

class CatFactLoading extends CatFactState {}

class CatFactLoaded extends CatFactState {
  final String fact;

  CatFactLoaded(this.fact) {}
}

class CatFactError extends CatFactState {
  final String message;

  CatFactError(this.message) {}
}

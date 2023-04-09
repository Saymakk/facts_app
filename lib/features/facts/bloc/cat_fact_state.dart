part of 'cat_fact_bloc.dart';

@immutable
abstract class CatFactState {}

class CatFactInitial extends CatFactState {}
class CatFactLoading extends CatFactState {}
class CatFactLoaded extends CatFactState {}

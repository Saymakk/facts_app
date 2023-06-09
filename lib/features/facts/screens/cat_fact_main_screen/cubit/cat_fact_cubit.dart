import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../../../retrofit_repository/cat_fact/cat_fact_service.dart';

part 'cat_fact_state.dart';

class CatFactCubit extends Cubit<CatFactState> {
  CatFactCubit() : super(CatFactInitial());

  final _date = DateTime.now();

  final _box = Hive.box('facts');

  Future<void> fetchFact() async {
    final dio = Dio();
    emit(CatFactLoading());
    try {
      print("LOADING FACT.....");
      final fact = await CatFactService(dio).getFact();
      Map facts = {
        'fact': fact,
        'date':
            '${_date.year}.${_date.month}.${_date.day} / ${_date.hour}:${_date.minute}',
      };
      _box.add(facts);
      print(_box.values);
      emit(CatFactLoaded(fact as String));
    } catch (e) {
      emit(CatFactError('Failed to fetch fact'));
    }
  }
}

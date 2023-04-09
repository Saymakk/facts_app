import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:facts_app/retrofit_repository/cat_fact_service.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../repository/abstract_api.dart';
import '../../../repository/cat_fact_api.dart';

part 'cat_fact_state.dart';

class CatFactCubit extends Cubit<CatFactState> {
  CatFactCubit() : super(CatFactInitial());
  final _box = Hive.box('facts');

  Future<void> fetchFact() async {
    final dio = Dio();
    emit(CatFactLoading());
    try {
      print("LOADING.....");
      final fact = await RestClient(dio).getFact();
      Map facts = {
        'fact': fact,
        'date':
            '${DateTime.now().year}.${DateTime.now().month}.${DateTime.now().day} / ${DateTime.now().hour}:${DateTime.now().minute}',
      };
      _box.add(facts);
      print(_box.values);
      emit(CatFactLoaded(fact as String));
    } catch (e) {
      emit(CatFactError('Failed to fetch fact'));
    }
  }
}

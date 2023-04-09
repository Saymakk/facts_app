import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../repository/abstract_api.dart';
import '../../../repository/cat_fact_api.dart';

part 'cat_fact_state.dart';

class CatFactCubit extends Cubit<CatFactState> {
  CatFactCubit() : super(CatFactInitial());
  final _box = Hive.box('facts');
  Future<void> fetchFact() async {
    emit(CatFactLoading());
    try {

      print("LOADING.....");
      final fact = await FactApiRepository().fetchFact();

      _box.add(fact);
      print(_box.values);
      emit(CatFactLoaded(fact));
    } catch (e) {
      emit(CatFactError('Failed to fetch fact'));
    }
  }
}

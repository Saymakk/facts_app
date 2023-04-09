import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:facts_app/repository/cat_fact_api.dart';
import 'package:meta/meta.dart';

part 'cat_fact_event.dart';
part 'cat_fact_state.dart';

// class CatFactBloc extends Bloc<CatFactEvent, CatFactState> {
//   CatFactBloc() : super(CatFactInitial()) {
//     on<CatFactLoad>((event, emit) {
//       print('Load');
//     });
//   }
//   // final FactApiProvider factApiProvider;
// }

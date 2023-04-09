import 'package:facts_app/features/facts/cubit/cat_fact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/facts/screens/cat_fact_main_screen/cat_fact_screen.dart';


class FactApp extends StatelessWidget {
  const FactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (BuildContext context) => CatFactCubit(),
        child: FactScreen(),
      ),
    );
  }
}

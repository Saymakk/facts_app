import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../features/facts/screens/cat_fact_main_screen/cat_fact_screen.dart';
import '../features/facts/screens/cat_fact_main_screen/cubit/cat_fact_cubit.dart';
import '../features/facts/screens/cat_fact_main_screen/cubit/cat_image_cubit.dart';

class FactApp extends StatelessWidget {
  const FactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffeafff2),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.merriweather().fontFamily,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => CatFactCubit(),
            child: const FactScreen(),
          ),
          BlocProvider(
            create: (BuildContext context) => CatImageCubit(),
            child: const FactScreen(),
          ),
        ],
        child: FactScreen(),
      )
    );
  }
}

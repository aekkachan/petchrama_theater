import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petchrama_theater/presentation/page/all_movies_view.dart';
import 'package:petchrama_theater/presentation/page/home_view.dart';
import 'package:petchrama_theater/presentation/page/search_movies_view.dart';
import 'package:petchrama_theater/presentation/page/test.dart';

void main() {
  // unawaited(RiveFile.);
  runApp(
    // To install Riverpod, we need to add this widget above everything else.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  // bebasNeueTextTheme
  // oswaldTextTheme
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.light().copyWith(
      //     textTheme: GoogleFonts.bebasNeueTextTheme().apply(
      //   bodyColor: Colors.black,
      // )),
      darkTheme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.latoTextTheme().apply(
        bodyColor: Colors.white,
      )),
      themeMode: ThemeMode.dark,
      home: AllMoviesView(),
      // home: HomeView(),
    );
  }
}

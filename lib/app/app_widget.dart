import 'package:flutter/material.dart';
import 'package:pokedex/app/feature/home/views/home_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(fontSize: 15),
        ),
        primaryColor: const Color(0xffff5048),
        textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 24, color: Colors.white)),
        scaffoldBackgroundColor: const Color(0xff444444),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff444444),
        ),
      ),
      home: const HomeView(),
    );
  }
}

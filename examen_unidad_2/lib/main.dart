import 'package:flutter/material.dart';
import 'router/list_routers.dart';
import 'router/routers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen 2',
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 43, 163, 237),
        ),
      ),
      initialRoute: Routers.login,
      routes: ListRouters.listScreens,
    );
  }
}

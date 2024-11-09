import 'package:examen_unidad_2/router/routers.dart';
import 'package:flutter/material.dart';
import 'router/list_routers.dart';
import 'router/routers.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
        ),
      ),
      initialRoute: Routers.login, 
      routes: ListRouters.listScreens,
    );
  }
}

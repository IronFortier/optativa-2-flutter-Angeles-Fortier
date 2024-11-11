import 'package:examen_unidad_2/screens/categories_view.dart';
import 'package:examen_unidad_2/screens/login_view.dart';
import 'package:flutter/material.dart';
import 'routers.dart';

class ListRouters {
  static final Map<String, Widget Function(BuildContext)> listScreens = {
    Routers.login: (context) => LoginView(),
    Routers.categories: (context) => CategoriesView(), // Debe coincidir con el valor en Routers
  };
}

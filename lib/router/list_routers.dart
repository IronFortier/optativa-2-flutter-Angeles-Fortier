import 'package:examen_unidad_2/router/menu_option.dart';
import 'package:examen_unidad_2/screens/categories_view.dart';
import 'package:examen_unidad_2/screens/login_view.dart';
import 'package:flutter/material.dart';
import 'package:examen_unidad_2/router/routers.dart';

class ListRouters {
  static final Map<String, Widget Function(BuildContext)> listScreens = {
    Routers.login: (context) => LoginView(),
    Routers.categories: (context) => CategoriesView(),
  };

  static List<MenuOption> menuOption = [
    MenuOption(
      route: '/login',
      screen: LoginView(),
      icon: Icons.login,
      description: 'Pantalla de Login',
    ),
    MenuOption(
      route: '/categories',
      screen: CategoriesView(),
      icon: Icons.category,
      description: 'Pantalla de Categorías',
    ),
  ];
}

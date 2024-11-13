import 'package:examen_unidad_2/infraestructure/connection/api_crud.dart';
import 'package:examen_unidad_2/modules/categories/domain/repository/category_rep.dart';
import 'package:examen_unidad_2/modules/products/domain/repository/product_rep.dart';
import 'package:flutter/material.dart';
import 'router/list_routers.dart';
import 'router/routers.dart';

void main() {
  final apiCrudService = ApiCrud(baseUrl: 'https://dummyjson.com');

  runApp(MyApp(
    categoryRepository: CategoryRepository(apiCrudService: apiCrudService),
    productRepository: ProductRepository(apiCrudService: apiCrudService),
  ));
}

class MyApp extends StatelessWidget {
  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;

  const MyApp({
    required this.categoryRepository,
    required this.productRepository,
    Key? key,
  }) : super(key: key);

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

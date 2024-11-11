import 'package:examen_unidad_2/infraestructure/connection/api_crud.dart';
import 'package:examen_unidad_2/modules/login/domain/repository/category_rep.dart';
import 'package:examen_unidad_2/modules/login/domain/repository/product_rep.dart';
import 'package:examen_unidad_2/screens/products_view.dart';
import 'package:examen_unidad_2/screens/categories_view.dart';
import 'package:examen_unidad_2/screens/login_view.dart';
import 'package:flutter/material.dart';
import 'routers.dart';

class ListRouters {
  // Declaramos apiCrudService como instancia antes de crear los repositorios
  final ApiCrud apiCrudService = ApiCrud(baseUrl: 'https://dummyjson.com');

  // Luego, utilizamos apiCrudService para inicializar los repositorios
  late final ProductRepository productRepository;
  late final CategoryRepository categoryRepository;

  ListRouters() {
    // Inicializamos los repositorios en el constructor
    productRepository = ProductRepository(apiCrudService: apiCrudService);
    categoryRepository = CategoryRepository(apiCrudService: apiCrudService);
  }

  static final Map<String, Widget Function(BuildContext)> listScreens = {
    Routers.login: (context) => LoginView(),
    Routers.categories: (context) => CategoriesView(
          categoryRepository: ListRouters().categoryRepository,
        ),
    Routers.productDetail: (context) => ProductsView(
          categorySlug: ModalRoute.of(context)!.settings.arguments as String,
          productRepository: ListRouters().productRepository,
        ),
  };
}

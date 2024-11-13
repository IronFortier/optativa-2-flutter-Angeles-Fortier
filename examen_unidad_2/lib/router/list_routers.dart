import 'package:examen_unidad_2/infraestructure/app/useCase/Auth.dart';
import 'package:examen_unidad_2/modules/categories/domain/repository/category_repository.dart';
import 'package:examen_unidad_2/modules/categories/useCase/category_usecase.dart';
import 'package:examen_unidad_2/modules/products/domain/repository/product_reppsitory.dart';
import 'package:examen_unidad_2/modules/products/useCase/products_usecase.dart';
import 'package:examen_unidad_2/screens/categories_view.dart';
import 'package:examen_unidad_2/screens/login_view.dart';
import 'package:examen_unidad_2/screens/products_view.dart';
import 'package:flutter/material.dart';
import 'routers.dart';

class ListRouters {
  
  static final Map<String, Widget Function(BuildContext)> listScreens = {
    Routers.login: (context) => LoginView(),

    Routers.categories: (context) => CategoriesView(UCcategory: CategoryUsecase(CategoryRepository(auth: Auth()))),

    Routers.products: (context) {
      // Cambia `arguments` para recibir directamente el String
      final String category = ModalRoute.of(context)!.settings.arguments as String;

      return ProductsView(
        UCproducts: ProductsUsecase(ProductRepository(auth: Auth())),
        category: category,
      );
    },
  




    // Routers.productDetail: (context) => ProductsView(
    //       categorySlug: ModalRoute.of(context)!.settings.arguments as String,
    //       productRepository: ListRouters().productRepository,
    //     ),
  };
}

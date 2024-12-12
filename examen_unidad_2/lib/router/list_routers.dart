import 'package:examen_unidad_2/infraestructure/app/useCase/Auth.dart';
import 'package:examen_unidad_2/modules/cart/domain/repository/cart_repository.dart';
import 'package:examen_unidad_2/modules/cart/useCase/cart_usecase.dart';
import 'package:examen_unidad_2/modules/categories/domain/repository/category_repository.dart';
import 'package:examen_unidad_2/modules/categories/useCase/category_usecase.dart';
import 'package:examen_unidad_2/modules/lastseen/usecase/lastseen_usecase.dart';
import 'package:examen_unidad_2/modules/products/domain/dto/product_dto.dart';
import 'package:examen_unidad_2/modules/products/domain/repository/product_reppsitory.dart';
import 'package:examen_unidad_2/modules/products/useCase/products_usecase.dart';
import 'package:examen_unidad_2/modules/search/domain/repository/search_repository.dart';
import 'package:examen_unidad_2/modules/search/usecase/search_usecase.dart';
import 'package:examen_unidad_2/screens/cart_view.dart';
import 'package:examen_unidad_2/screens/categories_view.dart';
import 'package:examen_unidad_2/screens/final_purchase.dart';
import 'package:examen_unidad_2/screens/finder_view.dart';
import 'package:examen_unidad_2/screens/last_seen_view.dart';
import 'package:examen_unidad_2/screens/login_view.dart';
import 'package:examen_unidad_2/screens/navigation_menu_view.dart';
import 'package:examen_unidad_2/screens/product_detail_view.dart';
import 'package:examen_unidad_2/screens/products_view.dart';
import 'package:flutter/material.dart';
import 'routers.dart';

class ListRouters {
  static final Map<String, Widget Function(BuildContext)> listScreens = {

    Routers.login: (context) => LoginView(),

    Routers.categories: (context) => NavigationExample(child: CategoriesView(
        UCcategory: CategoryUsecase(CategoryRepository(auth: Auth())))),

    Routers.products: (context) {
      // Cambia `arguments` para recibir directamente el String
      final String category =
          ModalRoute.of(context)!.settings.arguments as String;

      return NavigationExample(child: ProductsView(
        UCproducts: ProductsUsecase(ProductRepository(auth: Auth())),
        category: category,
      ));
    },

    Routers.finalpurchase: (context) => NavigationExample(child: PurchasesView()),


    Routers.finder: (context) => NavigationExample(child: FinderView(searchUseCase: SearchUseCase(SearchRepository()))),


    Routers.lastseen: (context) => NavigationExample(child: LastSeenView(UClastseen: LastseenUsecase(ProductRepository(auth: Auth())))),

    // Routers.productDetail: (context) {
    //   final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //   final product = arguments['product'] as ProductDto;

    //   return NavigationExample(child: ProductDetailView(
    //     product: product,
    //   ));
    // },

    Routers.productDetail: (context) {
  // Asegúrate de que los argumentos sean un Map<String, dynamic>
  final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  final product = arguments['product'] as ProductDto;

  return NavigationExample(child: ProductDetailView(
    product: product,
  ));
},


    Routers.cart: (context) => NavigationExample(child: CartView(cartUsecase: CartUsecase(CartRepository()))),

   

  };
}

import 'package:examen_unidad_2/modules/products/domain/dto/product_dto.dart';
import 'package:examen_unidad_2/modules/lastseen/domain/dto/seen_dto.dart';
import 'package:examen_unidad_2/modules/products/domain/repository/product_reppsitory.dart';
import 'package:localstorage/localstorage.dart';

class ProductsUsecase {
  final ProductRepository products;
  
  final LocalStorage storage = LocalStorage('localstorage_app');
  ProductsUsecase (this.products);

  Future<List<ProductDto>> GetRepository(String category) async {
    
    return await products.getProducts(category);
  }

  

   
  Future<void> saveSeen(ProductDto product) async {

    List<dynamic> seens = await storage.getItem('seen') ?? [];

    seens.add(product.toJson());

    await storage.setItem('seen', seens);
  }
  }
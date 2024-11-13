import 'package:examen_unidad_2/modules/products/domain/dto/product_dto.dart';
import 'package:examen_unidad_2/modules/products/domain/repository/product_reppsitory.dart';

class ProductsUsecase {
  final ProductRepository products;

  ProductsUsecase (this.products);

  Future<List<ProductDto>> GetRepository(String category) async {
    
    return await products.getProducts(category);
  }

  }
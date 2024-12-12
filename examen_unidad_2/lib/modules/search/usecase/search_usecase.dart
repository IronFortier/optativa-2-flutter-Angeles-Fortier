import 'package:examen_unidad_2/modules/products/domain/dto/product_dto.dart';
import 'package:examen_unidad_2/modules/search/domain/repository/search_repository.dart';
import 'package:localstorage/localstorage.dart';


class SearchUseCase {
  final SearchRepository _repository;
  final LocalStorage storage = LocalStorage('localstorage_app');
  SearchUseCase(this._repository);

  Future<List<ProductDto>> searchProducts(String query) async {
    final products = await _repository.searchProducts(query);
    return products.map<ProductDto>((product) => ProductDto.fromJson(product)).toList();
  }

   Future<void> saveSeen(ProductDto product) async {

    List<dynamic> seens = await storage.getItem('seen') ?? [];

    seens.add(product.toJson());

    await storage.setItem('seen', seens);
  }
}

import 'dart:convert';
import 'package:examen_unidad_2/infraestructure/connection/api_crud.dart';
import '../../domain/dto/product_dto.dart';

class ProductRepository {
  final ApiCrud apiCrudService;

  ProductRepository({required this.apiCrudService});

  Future<List<ProductDto>> getProductsByCategory(String categorySlug) async {
    final response = await apiCrudService.get('products/category/$categorySlug');

    // Imprimir la respuesta para depuración
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('products')) {
        final List<dynamic> productsJson = data['products'];
        return productsJson.map((json) => ProductDto.fromJson(json)).toList();
      } else {
        throw Exception('La respuesta no contiene la clave "products"');
      }
    } else {
      throw Exception('Error al cargar los productos: ${response.statusCode}');
    }
  }
}

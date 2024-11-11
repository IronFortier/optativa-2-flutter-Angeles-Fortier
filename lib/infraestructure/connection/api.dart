import 'dart:convert';
import 'package:examen_unidad_2/modules/login/domain/dto/categories_dto.dart';
import 'package:examen_unidad_2/modules/login/domain/dto/product_dto.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://dummyjson.com';

  Future<List<CategoryDto>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CategoryDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<ProductDto>> fetchProductsByCategory(String categorySlug) async {
    final response = await http.get(Uri.parse('$baseUrl/products/category/$categorySlug'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> productsJson = data['products'];
      return productsJson.map((json) => ProductDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}

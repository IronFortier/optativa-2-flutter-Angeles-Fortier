import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchRepository {
  final String _baseUrl = 'https://dummyjson.com/products/search';

  Future<List<dynamic>> searchProducts(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl?q=$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['products'] ?? [];
    } else {
      throw Exception('Error al buscar productos: ${response.reasonPhrase}');
    }
  }
}

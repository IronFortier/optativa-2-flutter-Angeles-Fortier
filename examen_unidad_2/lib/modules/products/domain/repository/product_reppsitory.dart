import 'dart:convert';
import 'package:examen_unidad_2/infraestructure/app/useCase/Auth.dart';
import 'package:examen_unidad_2/infraestructure/connection/connection.dart';
import '../dto/product_dto.dart';


class ProductRepository {
  final Auth auth;  

  ProductRepository({required this.auth});

  Future<List<ProductDto>> getProducts(String category) async {
    
    final String Url = "https://dummyjson.com/products/category/$category";
    Connection connection = Connection();

    final token = await auth.getAuthToken();
    if (token == null) {
      throw Exception('No se encontró el token de autenticación');
    }

    final response = await connection.get(Url, headers: {
      'Content-Type': 'application/json',
    });
    

     // Accede a la clave `products` dentro del Map
    final List<dynamic> data = response['products'];
    return data.map((json) => ProductDto.fromJson(json)).toList();
  }
}
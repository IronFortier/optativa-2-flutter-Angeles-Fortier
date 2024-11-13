import 'package:examen_unidad_2/infraestructure/app/useCase/Auth.dart';
import 'package:examen_unidad_2/infraestructure/connection/connection.dart';
import 'package:examen_unidad_2/modules/categories/domain/dto/category_dto.dart';

class CategoryRepository {
  final Auth auth;
  final String Url = "https://dummyjson.com/products/categories";

  CategoryRepository({required this.auth});

  Future<List<CategoryDto>> getCategories() async {
    Connection connection = Connection();

    final token = await auth.getAuthToken();
    if (token == null) {
      throw Exception('No se encontró el token de autenticación');
    }

    // Llama a la API y obtén la respuesta como una lista
    final response = await connection.get<List<dynamic>>(Url, headers: {
      'Content-Type': 'application/json',
    });

    // Convertimos cada elemento de `response` a `CategoryDto`
    return response
        .map((json) => CategoryDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
// print("Tipo de response: ${response.runtimeType}");
    // print("Contenido de response: $response");
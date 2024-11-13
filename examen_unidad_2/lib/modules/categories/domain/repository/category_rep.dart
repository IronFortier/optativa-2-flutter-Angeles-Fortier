import 'dart:convert';
import 'package:examen_unidad_2/infraestructure/connection/api_crud.dart';
import 'package:examen_unidad_2/modules/categories/domain/dto/category_dto.dart';


class CategoryRepository {
  final ApiCrud apiCrudService;

  CategoryRepository({required this.apiCrudService});

  Future<List<CategoryDto>> getCategories() async {
    final response = await apiCrudService.get('products/categories');
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => CategoryDto.fromJson(json)).toList();
  }
}

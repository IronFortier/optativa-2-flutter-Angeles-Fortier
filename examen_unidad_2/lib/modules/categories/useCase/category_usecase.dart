import 'package:examen_unidad_2/modules/categories/domain/dto/category_dto.dart';
import 'package:examen_unidad_2/modules/categories/domain/repository/category_repository.dart';

class CategoryUsecase {
  final CategoryRepository categories;

  CategoryUsecase(this.categories);

  Future<List<CategoryDto>> GetRepository() async {
    
    return await categories.getCategories();
  }

}


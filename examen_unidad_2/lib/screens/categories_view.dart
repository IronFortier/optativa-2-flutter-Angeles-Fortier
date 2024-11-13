import 'package:examen_unidad_2/modules/categories/domain/dto/category_dto.dart';
import 'package:examen_unidad_2/modules/categories/domain/repository/category_rep.dart';
import 'package:examen_unidad_2/Widgets/general/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:examen_unidad_2/router/routers.dart';

class CategoriesView extends StatefulWidget {
  final CategoryRepository categoryRepository;

  CategoriesView({required this.categoryRepository});

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  late Future<List<CategoryDto>> categoriesFuture;

  @override
  void initState() {
    super.initState();
    categoriesFuture = widget.categoryRepository.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Categorías"),
      body: FutureBuilder<List<CategoryDto>>(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay categorías disponibles'));
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                final category = snapshot.data![index];
                final isEven = index % 2 == 0;
                return Container(
                  color: isEven ? Colors.grey.shade200 : Colors.white,
                  child: ListTile(
                    leading: Icon(
                      isEven ? Icons.shopping_bag : Icons.fastfood,
                      color: isEven ? Colors.blue : Colors.red,
                    ),
                    title: Text(category.name),
                    trailing: Icon(
                      Icons.chevron_right, // Icono de ">"
                      color: isEven ? Colors.blue : Colors.red,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routers.productDetail,
                        arguments: category.slug,
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

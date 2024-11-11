import 'package:examen_unidad_2/modules/login/domain/dto/category_dto.dart';
import 'package:examen_unidad_2/modules/login/domain/repository/category_rep.dart';
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
      appBar: AppBar(
        title: Text('Categorías'),
      ),
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
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final category = snapshot.data![index];
                return ListTile(
                  leading: Icon(Icons.category),
                  title: Text(category.name),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routers.productDetail,
                      arguments: category.slug,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

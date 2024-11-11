import 'package:examen_unidad_2/infraestructure/connection/api.dart';
import 'package:examen_unidad_2/modules/login/domain/dto/categories_dto.dart';
import 'package:examen_unidad_2/screens/products_view.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatefulWidget {
  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  late Future<List<CategoryDto>> categoriesFuture;

  @override
  void initState() {
    super.initState();
    categoriesFuture = ApiService().fetchCategories();
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
                  subtitle: Text(category.slug),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navegación a ProductsView con el slug de la categoría
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductsView(categorySlug: category.slug),
                      ),
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

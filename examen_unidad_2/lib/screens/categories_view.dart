import 'package:examen_unidad_2/Widgets/categories/category_list_items.dart';
import 'package:examen_unidad_2/Widgets/general/custom_appbar.dart';
import 'package:examen_unidad_2/modules/categories/domain/dto/category_dto.dart';
import 'package:examen_unidad_2/modules/categories/useCase/category_usecase.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  final CategoryUsecase UCcategory;
  CategoriesView({Key? key, required this.UCcategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("se abre la pantalla");
    return Scaffold(
      appBar: const CustomAppbar(title: "Categorias"),
      body: FutureBuilder(
        future: UCcategory.GetRepository(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // Comprobamos si el error es por la falta de autenticación
            if (snapshot.error
                .toString()
                .contains("No se encontró el token de autenticación")) {
              // Si no está autenticado, redirigimos a la pantalla de login
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, '/login');
              });
              print("pal lobby");
              return const Center(child: Text("Redirigiendo al login"));
            

            }

            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            // Verificamos si los datos recibidos son una lista
            print("entre aqui");
            if (snapshot.data is List) {
              final List<CategoryDto> categories = snapshot.data!;
              
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryListItem(
                    name: category.name,
                    slug: category.slug,
                    index: index,
                  );
                },
              );
            } else {
              return Center(child: Text("Formato de datos incorrecto"));
            }
          }

          return Center(child: Text("No hay categorías disponibles"));
        },
      ),
    );
  }
}

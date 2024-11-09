import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'RAÍZ', 'date': '2022-12-01 23:57:02.000'},
      {'title': 'INICIO', 'date': '2022-12-01 23:57:02.000'},
      // Agrega más categorías aquí...
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text(category['title']!),
            subtitle: Text(category['date']!),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Aquí se define la acción al seleccionar una categoría
            },
          );
        },
      ),
    );
  }
}

// lib/screens/categories_view.dart

import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorías"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Bienvenido a la vista de categorías',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

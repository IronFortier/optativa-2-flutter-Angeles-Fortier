import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:examen_unidad_2/modules/products/domain/dto/product_dto.dart';
import 'package:examen_unidad_2/router/routers.dart';
import 'package:examen_unidad_2/Widgets/general/custom_button.dart';

class LastSeenView extends StatefulWidget {
  @override
  _LastSeenViewState createState() => _LastSeenViewState();
}

class _LastSeenViewState extends State<LastSeenView> {
  List<Map<String, dynamic>> _seenProducts = [];

  @override
  void initState() {
    super.initState();
    _loadSeenProducts();
  }

  // Cargar los productos vistos desde localStorage
  Future<void> _loadSeenProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final seenProductsJson = prefs.getString('seenProducts') ?? '[]';
    final seenProducts = List<Map<String, dynamic>>.from(jsonDecode(seenProductsJson));

    setState(() {
      _seenProducts = seenProducts;
    });
  }

  // Incrementar el contador de vistas de un producto
  Future<void> _incrementViewCount(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final seenProductsJson = prefs.getString('seenProducts') ?? '[]';
    final seenProducts = List<Map<String, dynamic>>.from(jsonDecode(seenProductsJson));

    for (var product in seenProducts) {
      if (product['id'] == productId) {
        product['viewCount'] += 1;
      }
    }

    await prefs.setString('seenProducts', jsonEncode(seenProducts));
    _loadSeenProducts();
  }

  // Agregar al carrito (dummy acción)
  void _addToCart(ProductDto product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.title} agregado al carrito')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _seenProducts.isEmpty
          ? const Center(child: Text('No has visto ningún producto'))
          : ListView.builder(
              itemCount: _seenProducts.length,
              itemBuilder: (context, index) {
                final product = _seenProducts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Image.network(
                      product['imageUrl'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    ),
                    title: Text(product['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Precio: \$${product['price']}'),
                        Text('Visto: ${product['viewCount']} veces'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        final dto = ProductDto(
                          id: product['id'],
                          title: product['title'],
                          description: product['description'],
                          imageUrl: product['imageUrl'],
                          price: product['price'],
                          stock: product['stock'],
                          reviews: product['reviews']
                        );
                        _addToCart(dto);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

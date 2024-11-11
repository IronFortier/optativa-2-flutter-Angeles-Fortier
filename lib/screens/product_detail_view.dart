import 'package:examen_unidad_2/modules/login/domain/dto/product_dto.dart';
import 'package:flutter/material.dart';

class ProductDetailView extends StatelessWidget {
  final ProductDto product;

  ProductDetailView({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              product.imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              product.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              product.description,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Precio: \$${product.price}', style: TextStyle(fontSize: 18)),
                Text('Stock: ${product.stock}', style: TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Acción para agregar al carrito (implementar según necesidades)
              },
              icon: Icon(Icons.add),
              label: Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }
}

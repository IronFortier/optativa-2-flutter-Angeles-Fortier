import 'package:examen_unidad_2/screens/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:examen_unidad_2/modules/login/domain/dto/product_dto.dart';

class ProductDetailView extends StatelessWidget {
  final ProductDto product;

  const ProductDetailView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Detalle de producto"),
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
            const SizedBox(height: 20),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.8, // Reduce el ancho de la descripción
              child: Text(
                product.description,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Precio: \$${product.price}',
                  style: const TextStyle(fontSize: 16), // Misma tipografía que la descripción
                ),
                Text(
                  'Stock: ${product.stock}',
                  style: const TextStyle(fontSize: 16), // Misma tipografía que la descripción
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: 120,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Acción para agregar al carrito
                },
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Agregar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Borde radius de 5
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10), // Altura ajustada
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

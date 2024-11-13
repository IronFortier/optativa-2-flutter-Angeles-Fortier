import 'package:flutter/material.dart';
import 'package:examen_unidad_2/modules/products/domain/dto/product_dto.dart';

import 'package:examen_unidad_2/Widgets/general/custom_appbar.dart';

class ProductDetailView extends StatefulWidget {
  final ProductDto product;

  const ProductDetailView({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final TextEditingController _quantityController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Detalle de producto", showCartIcon: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              widget.product.imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              widget.product.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                widget.product.description,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Precio: \$${widget.product.price}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Stock: ${widget.product.stock}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cantidad',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 20),
         
            SizedBox(
              height: 40,
              width: 120,
              // child: ElevatedButton.icon(
              //   onPressed: _handleAddToCart, // Aquí llamamos al método
              //   icon: const Icon(Icons.add, size: 16),
              //   label: const Text('Agregar'),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

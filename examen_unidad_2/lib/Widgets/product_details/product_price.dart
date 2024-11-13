import 'package:flutter/material.dart';

class ProductPriceAndStock extends StatelessWidget {
  final double price;
  final int stock;

  const ProductPriceAndStock({Key? key, required this.price, required this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Precio: \$${price.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Stock: $stock',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

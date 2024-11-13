import 'package:examen_unidad_2/Widgets/product_details/Quantity_input.dart';
import 'package:examen_unidad_2/Widgets/product_details/product_description.dart';
import 'package:examen_unidad_2/Widgets/product_details/product_image.dart';
import 'package:examen_unidad_2/Widgets/product_details/product_price.dart';
import 'package:examen_unidad_2/Widgets/product_details/product_title.dart';
import 'package:examen_unidad_2/Widgets/general/custom_button.dart';
import 'package:examen_unidad_2/modules/product_details/useCase/product_details_usecase.dart';
import 'package:flutter/material.dart';
import 'package:examen_unidad_2/modules/products/domain/dto/product_dto.dart';
import 'package:examen_unidad_2/Widgets/general/custom_appbar.dart';

class ProductDetailView extends StatelessWidget {
  final ProductDto product;

  ProductDetailView({Key? key, required this.product}) : super(key: key);

  final TextEditingController quantityController = TextEditingController();

  final ProductDetailsUsecase UCprod = ProductDetailsUsecase();

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Detalle de producto", showCartIcon: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProductImage(imageUrl: product.imageUrl),
            const SizedBox(height: 20),
            ProductTitle(title: product.title),
            const SizedBox(height: 10),
            ProductDescription(description: product.description),
            const SizedBox(height: 20),
            ProductPriceAndStock(price: product.price, stock: product.stock),
            const SizedBox(height: 20),
            QuantityInput(controller: quantityController),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Agregar al carrito',
              icon: Icons.add_shopping_cart,
              Action: () {
                final quantity = int.tryParse(quantityController.text) ?? 0;
                UCprod.addToCart(product, quantity, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

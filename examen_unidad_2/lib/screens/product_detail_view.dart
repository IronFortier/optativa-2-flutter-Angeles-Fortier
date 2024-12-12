import 'package:examen_unidad_2/Widgets/product_details/Quantity_input.dart';
import 'package:examen_unidad_2/Widgets/product_details/conditional.dart';
import 'package:examen_unidad_2/Widgets/product_details/conditionalbuton.dart';
import 'package:examen_unidad_2/Widgets/product_details/product_description.dart';
import 'package:examen_unidad_2/Widgets/product_details/product_image.dart';
import 'package:examen_unidad_2/Widgets/product_details/product_price.dart';
import 'package:examen_unidad_2/Widgets/product_details/product_title.dart';
import 'package:examen_unidad_2/modules/product_details/useCase/product_details_usecase.dart';
import 'package:examen_unidad_2/router/routers.dart';
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
      appBar: AppBar(
        title: const Text("Detalle de producto"),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              Divider(),

              // Comprobación si el carrito está lleno
              ConditionalDisplayWidget(
                condition: UCprod.isCartFull,
                message: "El carrito ya se encuentra lleno :(",
                icon: Icons.shopping_cart,
                action: () {
                  Navigator.pushNamed(context, Routers.cart);
                },
              ),

              // Comprobación de stock del producto
              ConditionalDisplayWidget(
                condition: () =>
                    UCprod.isQuantityEqualOrExceedingStock(product),
                message: "Producto agotado :(",
                icon: Icons.shopping_cart,
                action: () {
                  Navigator.pushNamed(context, Routers.cart);
                },
              ),

              // Botón Agregar al carrito
              ConditionalButton(
                product: product,
                usecase: UCprod,
                quantityController: quantityController,
              ),
              const SizedBox(height: 20),

              // Mostrar las reviews del producto
              const Divider(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Reseñas:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              // Reviews
              product.reviews.isNotEmpty
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: product.reviews.length,
                      itemBuilder: (context, index) {
                        final review = product.reviews[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                review.reviewerName[0], // Inicial del nombre
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(review.reviewerName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(review.comment),
                                Text(
                                  'Calificación: ${review.rating}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Fecha: ${review.date}',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'Este producto no tiene reseñas.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

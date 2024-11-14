import 'package:flutter/material.dart';
import 'package:examen_unidad_2/Widgets/general/custom_button.dart';
import 'package:examen_unidad_2/modules/products/domain/dto/product_dto.dart';
import 'package:examen_unidad_2/modules/product_details/useCase/product_details_usecase.dart';

class ConditionalButton extends StatelessWidget {
  final ProductDto product;
  final ProductDetailsUsecase usecase;
  final TextEditingController quantityController;

  const ConditionalButton({
    Key? key,
    required this.product,
    required this.usecase,
    required this.quantityController,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: usecase.shouldShowAddToCartButton(product),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra indicador de carga
        }

        

        // Mostrar el botón de "Agregar al carrito" solo si las condiciones anteriores son falsas
        if (snapshot.hasData && snapshot.data == true) {
          return CustomButton(
            label: 'Agregar al carrito',
            icon: Icons.add_shopping_cart,
            Action: () {
              final quantity = int.tryParse(quantityController.text) ?? 0;
              usecase.addToCart(product, quantity, context);
            },
          );
        }

        return SizedBox.shrink(); // Ocultar el botón si no se cumplen las condiciones
      },
    );
  }
}

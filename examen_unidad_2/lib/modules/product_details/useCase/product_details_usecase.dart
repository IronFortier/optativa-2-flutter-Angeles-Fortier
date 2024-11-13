import 'package:examen_unidad_2/modules/cart/domain/dto/cart_dto.dart';
import 'package:examen_unidad_2/modules/cart/domain/repository/cart_repository.dart';
import 'package:examen_unidad_2/modules/products/domain/dto/product_dto.dart';
import 'package:flutter/material.dart';

class ProductDetailsUsecase {
  final CartRepository cartRepository = CartRepository();

  // Método para verificar si el carrito tiene 7 productos distintos
  Future<bool> isCartFull() async {
    List<CartDto> cart = await cartRepository.getCart();
    return cart.length >= 7;
  }

  // Método para verificar si la cantidad de un producto en el carrito es igual o superior al stock disponible
Future<bool> isQuantityEqualOrExceedingStock(ProductDto product) async {
  List<CartDto> cart = await cartRepository.getCart();

  int existingProductIndex = cart.indexWhere((item) => item.product.id == product.id);

  if (existingProductIndex != -1) {
    int currentQuantity = cart[existingProductIndex].quantity;
    return currentQuantity >= product.stock;
  }
  return false;
}

  Future<void> addToCart(ProductDto product, int quantity, BuildContext context) async {
    // Obtener el carrito actual
    List<CartDto> cart = await cartRepository.getCart();

    if (quantity < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ingresa una cantidad válida")),
      );
      return;
    }

    // Verificar que no se exceda el límite de 7 productos distintos
    bool isProductInCart = cart.any((item) => item.product.id == product.id);
    if (cart.length >= 7 && !isProductInCart) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Solo se pueden comprar 7 artículos a la vez")),
      );
      return;
    }

    // Buscar si el producto ya está en el carrito
    int existingProductIndex = cart.indexWhere((item) => item.product.id == product.id);

    try {
      if (existingProductIndex != -1) {
        // Obtener la cantidad actual en el carrito
        int currentQuantity = cart[existingProductIndex].quantity;

        // Comprobar si la cantidad solicitada supera el stock disponible
        if (currentQuantity + quantity > product.stock) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Cantidad solicitada excede el stock disponible")),
          );
          return;
        }

        // Incrementa la cantidad si el producto ya existe y no supera el stock
        cart[existingProductIndex] = CartDto(
          product: cart[existingProductIndex].product,
          quantity: currentQuantity + quantity,
        );
      } else {
        // Comprobar si la cantidad solicitada supera el stock disponible para un nuevo producto
        if (quantity > product.stock) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Cantidad solicitada excede el stock disponible")),
          );
          return;
        }

        // Agrega el producto como un nuevo elemento en el carrito
        cart.add(CartDto(product: product, quantity: quantity));
      }

      // Guardar el carrito actualizado en Local Storage
      await cartRepository.saveCart(cart);

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Producto agregado al carrito")),
      );
    } catch (e) {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ocurrió un error: ${e.toString()}")),
      );
    }
  }
}

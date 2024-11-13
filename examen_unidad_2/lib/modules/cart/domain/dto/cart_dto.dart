import 'package:examen_unidad_2/modules/products/domain/dto/product_dto.dart';

class CartDto {
  final ProductDto product;
  final int quantity;

  CartDto({
    required this.product,
    required this.quantity,
  });

// Convierte CartDto a un mapa para almacenamiento en Local Storage
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(), // Convierte el producto a un mapa
      'quantity': quantity,
    };
  }

  // Construye CartDto desde un mapa de JSON
  factory CartDto.fromJson(Map<String, dynamic> json) {
    return CartDto(
      product: ProductDto.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
    );
  }

}

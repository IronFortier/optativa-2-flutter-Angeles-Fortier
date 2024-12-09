import 'package:examen_unidad_2/modules/products/domain/dto/product_dto.dart';

class SeenDto {
  final ProductDto product;

  SeenDto({
    required this.product,
  });

// Convierte SeenDto a un mapa para almacenamiento en Local Storage
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(), // Convierte el producto a un mapa
    };
  }

  // Construye SeenDto desde un mapa de JSON
  factory SeenDto.fromJson(Map<String, dynamic> json) {
  if (!json.containsKey('product')) {
    throw Exception('El JSON no contiene un producto válido');
  }

  final productJson = json['product'];
  if (productJson == null || productJson is! Map<String, dynamic>) {
    throw Exception('El producto no tiene un formato válido');
  }

  return SeenDto(
    product: ProductDto.fromJson(productJson),
  );
}


}

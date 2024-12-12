import 'package:examen_unidad_2/modules/products/domain/dto/reviews_dto.dart';

class ProductDto {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final int stock;
  final List<ReviewDto> reviews; // Nueva propiedad

  ProductDto({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.stock,
    required this.reviews,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
  return ProductDto(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String? ?? '', // Si puede ser null, usa un valor predeterminado
    imageUrl: json['thumbnail'] as String? ?? '',      // Evita errores con valores nulos
    price: (json['price'] as num?)?.toDouble() ?? 0.0, // Maneja números nulos
    stock: json['stock'] as int? ?? 0,                // Valores predeterminados si es null
    reviews: (json['reviews'] as List<dynamic>?)
            ?.map((review) => ReviewDto.fromJson(review))
            .toList() ?? [],                          // Lista vacía si no hay reseñas
  );
}


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail': imageUrl,
      'price': price,
      'stock': stock,
      'reviews': reviews.map((review) => review.toJson()).toList(), // Conversión de las reviews a JSON
    };
  }
}
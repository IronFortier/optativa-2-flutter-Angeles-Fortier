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
      description: json['description'] as String,
      imageUrl: json['thumbnail'] as String,
      price: (json['price'] as num).toDouble(),
      stock: json['stock'] as int,
      reviews: (json['reviews'] as List<dynamic>)
          .map((review) => ReviewDto.fromJson(review))
          .toList(), // Mapeo de la lista de reviews
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
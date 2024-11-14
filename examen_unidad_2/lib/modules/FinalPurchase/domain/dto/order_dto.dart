import 'package:examen_unidad_2/modules/cart/domain/dto/cart_dto.dart';


class OrderDto {
  final double total;
  final int totalProducts;
  final List<CartDto> items;
  final DateTime purchaseDate;

  OrderDto({
    required this.total,
    required this.totalProducts,
    required this.items,
    required this.purchaseDate,
  });

  // Método para crear un `OrderDto` desde JSON
  factory OrderDto.fromJson(Map<String, dynamic> json) {
    return OrderDto(
      total: json['total'] as double,
      totalProducts: json['totalProducts'] as int,
      items: (json['items'] as List<dynamic>)
          .map((item) => CartDto.fromJson(item as Map<String, dynamic>))
          .toList(),
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
    );
  }

  // Método para convertir `OrderDto` a JSON
  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'totalProducts': totalProducts,
      'items': items.map((item) => item.toJson()).toList(),
      'purchaseDate': purchaseDate.toIso8601String(),
    };
  }
}

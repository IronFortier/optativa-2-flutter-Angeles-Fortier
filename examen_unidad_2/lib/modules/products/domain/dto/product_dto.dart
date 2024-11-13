class ProductDto {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final int stock;

  ProductDto({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.stock,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['thumbnail'] as String, 
      price: (json['price'] as num).toDouble(),
      stock: json['stock'] as int,
    );
  }
}

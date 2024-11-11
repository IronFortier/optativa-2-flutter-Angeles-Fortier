class CategoryDto {
  final String slug;
  final String name;
  final String url;

  CategoryDto({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      slug: json['slug'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}

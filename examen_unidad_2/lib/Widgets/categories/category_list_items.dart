import 'package:examen_unidad_2/router/routers.dart';
import 'package:flutter/material.dart';

class CategoryListItem extends StatelessWidget {
  final String name;
  final String slug;
  final int index;

  const CategoryListItem({
    Key? key,
    required this.name,
    required this.slug,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isEven = index % 2 == 0;
    return Container(
      color: isEven ? Colors.grey.shade200 : Colors.white,
      child: ListTile(
        leading: Icon(
          isEven ? Icons.shopping_bag : Icons.fastfood,
          color: isEven ? Colors.blue : Colors.red,
        ),
        title: Text(name),
        trailing: Icon(
          Icons.chevron_right,
          color: isEven ? Colors.blue : Colors.red,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            Routers.products,
            arguments: slug,
          );
        },
      ),
    );
  }
}

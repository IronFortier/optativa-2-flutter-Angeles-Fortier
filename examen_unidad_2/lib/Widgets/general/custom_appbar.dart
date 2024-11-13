import 'package:examen_unidad_2/router/routers.dart';
import 'package:flutter/material.dart';
// import 'package:examen_unidad_2/screens/cart_view.dart'; // Importa la vista del carrito

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showCartIcon;

  const CustomAppbar({
    super.key,
    required this.title,
    this.showCartIcon = true, // Valor por defecto en true
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: const Color.fromARGB(255, 40, 40, 40),
      foregroundColor: Colors.white,
      elevation: 4.0,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      title: Text(title, textAlign: TextAlign.center),
      backgroundColor: Colors.blue,
      centerTitle: true,
      actions: showCartIcon
          ? [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, Routers.cart);
                },
              ),
            ]
          : [], // Si showCartIcon es false, no muestra ningún icono en actions
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

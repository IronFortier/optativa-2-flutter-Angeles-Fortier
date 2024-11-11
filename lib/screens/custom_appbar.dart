import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

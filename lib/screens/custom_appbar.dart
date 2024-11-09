import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
final String title;

const CustomAppbar({super.key, required this.title});

  @override
  Widget build(Object context) {
    return AppBar(
      shadowColor: const Color.fromARGB(255, 16, 199, 40),
      foregroundColor: Colors.white,
      
      titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      title: Text(title, textAlign: TextAlign.center),
      backgroundColor: Colors.blue,
      centerTitle: true,
    );
  }

@override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
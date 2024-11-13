import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget{

  final String label;
  final TextEditingController controller;

  CustomInput({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              ),
    );
  }

}
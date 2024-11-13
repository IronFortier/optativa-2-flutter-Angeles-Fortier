import 'package:flutter/material.dart';

class ConditionalDisplayWidget extends StatelessWidget {
  final Future<bool> Function() condition;
  final String message;
  final IconData icon;
  final VoidCallback action;

  const ConditionalDisplayWidget({
    Key? key,
    required this.condition,
    required this.message,
    required this.icon,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: condition(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasData && snapshot.data == true) {
          return Column(
            children: [
              Text(
                message,
                style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(icon, color: Colors.blue),
                onPressed: action,
              ),
            ],
          );
        }
        return SizedBox.shrink(); // No mostrar nada si la condición es falsa
      },
    );
  }
}

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{

  final String label;
  final IconData? icon;
  final VoidCallback Action;

  const CustomButton({
    super.key,
    required this.label,
    this.icon,
    required this.Action
  });


  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
              onPressed:Action,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.blue,
              ),
              icon: Icon(icon),
              label: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white, 
                ),
              ),
            );
  }

}
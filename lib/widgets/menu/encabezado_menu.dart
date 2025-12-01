import 'package:flutter/material.dart';

class EncabezadoMenu extends StatelessWidget {
  const EncabezadoMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(Icons.language, size: 80, color: Colors.indigo),
        SizedBox(height: 20),
        Text(
          "Vocabulario Didactico",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Aprende vocabulario jugando",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

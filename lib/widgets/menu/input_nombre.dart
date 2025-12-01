import 'package:flutter/material.dart';

class InputNombre extends StatelessWidget {
  final TextEditingController controlador;
  const InputNombre({super.key, required this.controlador});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      decoration: const InputDecoration(
        labelText: "Nombre de Jugador",
        hintText: "Quien va a jugar?",
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(),
      ),
    );
  }
}

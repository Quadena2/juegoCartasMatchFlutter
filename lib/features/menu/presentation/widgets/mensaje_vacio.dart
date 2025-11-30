import 'package:flutter/material.dart';

class MensajeVacio extends StatelessWidget {
  final String nombreJugador;
  const MensajeVacio({super.key, required this.nombreJugador});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_edu, size: 80, color: Colors.indigo.shade100,),
          const SizedBox(height: 20,),
          Text(
            "Aun no hay partidas registradas",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo.shade300),
          ),
          const SizedBox(height: 10,),
          Text(
            "Juega una partida para ver tu historial aqui \n$nombreJugador",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}

import 'package:card_memory_game_three/models/modelo_puntaje.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemHistorial extends StatelessWidget {
  final ModeloPuntaje puntaje;
  const ItemHistorial({super.key, required this.puntaje});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // Circulo con el puntaje
        leading: CircleAvatar(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          radius: 25,
          child: Text(
            puntaje.puntaje.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        // Titulo Categoria
        title: Text(
          _traducirCategoria(puntaje.idCategoria),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // Subtitulo de dificultad
        subtitle: Text("Dificultad: ${puntaje.dificultad}"),
        // Fecha
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Icon(Icons.calendar_today, size: 14, color: Colors.grey,),
            const SizedBox(height: 4,),
            Text(
              DateFormat('dd/MM - HH:mm').format(puntaje.fecha),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
  
  String _traducirCategoria(String id){
    switch (id){
      case 'animales' : return 'Animales';
      case 'colores' : return 'Colores';
      case 'numeros' : return 'Numeros';
      default: return id.toUpperCase();
    }
  }
}
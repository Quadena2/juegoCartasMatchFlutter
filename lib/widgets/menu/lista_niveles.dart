import 'package:card_memory_game_three/widgets/menu/boton_menu.dart';
import 'package:flutter/material.dart';

class ListaNiveles extends StatelessWidget {
  final Function(int, String, String) alSeleccionarNivel;
  const ListaNiveles({super.key, required this.alSeleccionarNivel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // Ingles 
        BotonMenu(
          texto: "Animales (Ingles) - 3x3",
          color: Colors.green,
          icono: Icons.pets,
          alPresionar: () => alSeleccionarNivel(3, 'animales', 'en'),
        ),
        const SizedBox(height: 12),

        BotonMenu(
          texto: "Colores (Ingles) - 4x4",
          color: Colors.purple,
          icono: Icons.palette,
          alPresionar: () => alSeleccionarNivel(4, 'colores', 'en'),
        ),
        const SizedBox(height: 12,),

        BotonMenu(
          texto: "Numeros (Ingles) - 5x5",
          color: Colors.orange,
          icono: Icons.looks_one,
          alPresionar: () => alSeleccionarNivel(5, 'numeros', 'en'),
        ),
        const SizedBox(height: 12,),

        // Español
        BotonMenu(
          texto: "Animales (Español) - 3x3",
          color: Colors.green,
          icono: Icons.pets,
          alPresionar: () => alSeleccionarNivel(3, 'animales', 'es'),
        ),
        const SizedBox(height: 12),

        BotonMenu(
          texto: "Colores (Español) - 4x4",
          color: Colors.purple,
          icono: Icons.palette,
          alPresionar: () => alSeleccionarNivel(4, 'colores', 'es'),
        ),
        const SizedBox(height: 12,),

        BotonMenu(
          texto: "Numeros (Español) - 5x5",
          color: Colors.orange,
          icono: Icons.looks_one,
          alPresionar: () => alSeleccionarNivel(5, 'numeros', 'es'),
        ),
        const SizedBox(height: 12,),

        // Aymara
        BotonMenu(
          texto: "Animales (Aymara) - 3x3",
          color: Colors.green,
          icono: Icons.pets,
          alPresionar: () => alSeleccionarNivel(3, 'animales', 'ay'),
        ),
        const SizedBox(height: 12),

        BotonMenu(
          texto: "Colores (Aymara) - 4x4",
          color: Colors.purple,
          icono: Icons.palette,
          alPresionar: () => alSeleccionarNivel(4, 'colores', 'ay'),
        ),
        const SizedBox(height: 12,),

        BotonMenu(
          texto: "Numeros (Aymara) - 5x5",
          color: Colors.orange,
          icono: Icons.looks_one,
          alPresionar: () => alSeleccionarNivel(5, 'numeros', 'ay'),
        ),
        const SizedBox(height: 12,),
      ],
    );
  }
}

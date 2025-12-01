import 'package:card_memory_game_three/models/carta_juego.dart';
import 'package:flutter/material.dart';

// Solo diseño de las cartas y sus cambio de colores
class CaraCarta extends StatelessWidget {
  final CartaJuego carta;
  // esFrente = true (oculto) - false (imagen/contenido)
  final bool esFrente;
  final bool estaEmparejada;

  const CaraCarta({
    super.key,
    required this.carta,
    required this.esFrente,
    required this.estaEmparejada,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: estaEmparejada ? Colors.green.shade100 : Colors.white,
        border: Border.all(
          color: estaEmparejada ? Colors.green : Colors.indigo.shade200,
          width: 2,
        ),
      ),
      child: Center(
        child: carta.esImagen
          ? Image.asset(
            carta.contenido,
            fit: BoxFit.contain,
            errorBuilder: (c,e,s) => const Icon(Icons.broken_image, color: Colors.grey,),
          )
        : FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            carta.contenido,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.indigo.shade900,
            ),
          ),
        )
      ),
    );
  }
}

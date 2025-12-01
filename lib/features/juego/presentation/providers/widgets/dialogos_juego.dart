import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DialogosJuego {
  static void mostrarVictoria(
    BuildContext context,
    int puntaje,
    VoidCallback alJugarOtraVez,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        title: const Column(
          children: [
            Icon(Icons.emoji_events, size: 60, color: Colors.amber),
            Text("Felicidades!"),
          ],
        ),
        content: Text(
          "Nivel Completado \nPuntiacion: $puntaje",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              alJugarOtraVez();
            },
            child: const Text("Jugar Otra Vez"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.of(context).pop();
            },
            child: const Text("Menu Principal"),
          ),
        ],
      ),
    );
  }

  static void mostrarDerrota(BuildContext context, VoidCallback alReintentar) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        title: const Column(
          children: [
            Icon(
              Icons.sentiment_very_dissatisfied,
              size: 60,
              color: Colors.red,
            ),
            Text("Has Perdido!"),
          ],
        ),
        content: const Text(
          "Has alcanzado el limite de 10 fallos",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              alReintentar();
            },
            child: const Text("Reintentar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.of(context).pop();
            },
            child: const Text("Salir"),
          ),
        ],
      ),
    );
  }

  static void confirmarReinicio(BuildContext context, VoidCallback alConfirmar){
    showDialog(
      context: context, 
      builder: (c) => AlertDialog(
        title: const Text("Reiniciar Juego?"),
        content: const Text("Perderas el progreso actual"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c), 
            child: const Text("Cancelar")
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(c);
              alConfirmar();
            }, 
            child: const Text("Reinicar")
          ),
        ],
      ),
    );
  }
}

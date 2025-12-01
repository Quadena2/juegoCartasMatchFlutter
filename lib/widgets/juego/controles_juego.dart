import 'package:card_memory_game_three/models/proveedor_juego.dart';
import 'package:flutter/material.dart';

class ControlesJuego extends StatelessWidget {
  final ProveedorJuego proveedor;
  final VoidCallback alReiniciar;

  const ControlesJuego({
    super.key,
    required this.proveedor,
    required this.alReiniciar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))]
      ),
      child: Row(
        children: [
          // Boton de Reiniciar
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text("Reiniciar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: alReiniciar, 
            ),
          ),
          const SizedBox(width: 16,),

          // Boton Pausar/Reanudar
          Expanded(
            child: ElevatedButton.icon(
              icon: Icon(proveedor.enPausa ? Icons.play_arrow : Icons.pause),
              label: Text(proveedor.enPausa ? "Reanudar" : "Pausar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12)
              ),
              onPressed: (proveedor.victoria || proveedor.juegoTerminado)
                  ? null
                  : proveedor.alternarPausa,
            ),
          ),
        ],
      ),
    );
  }
}

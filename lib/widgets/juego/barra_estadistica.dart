import 'package:card_memory_game_three/models/proveedor_juego.dart';
import 'package:flutter/material.dart';

class BarraEstadistica extends StatelessWidget {
  final ProveedorJuego proveedor;
  const BarraEstadistica({super.key, required this.proveedor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nro fallos
          _WidgetDato(
            icono: Icons.close,
            texto: "Fallos: ${proveedor.fallos}/10",
            color: Colors.red,
            esNegrilla: proveedor.fallos >= 3,
          ),

          // Tiempo
          _WidgetDato(
            icono: Icons.timer, 
            texto: _formatearTiempo(proveedor.segundosTranscurridos), 
            color: Colors.blue.shade800
          ),

          // Aciertos
          _WidgetDato(
            icono: Icons.check_circle, 
            texto: "Aciertos: ${proveedor.aciertos}", 
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  String _formatearTiempo(int totalSegundos){
    int min = totalSegundos ~/ 60;
    int sec = totalSegundos % 60;
    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }
}

class _WidgetDato extends StatelessWidget {
  final IconData icono;
  final String texto;
  final Color color;
  final bool esNegrilla;

  const _WidgetDato({
    required this.icono,
    required this.texto,
    required this.color,
    this.esNegrilla = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icono, color: color, size: 20),
        const SizedBox(width: 4),
        Text(
          texto,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: esNegrilla ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

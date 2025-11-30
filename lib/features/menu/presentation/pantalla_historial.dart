import 'package:card_memory_game_three/features/menu/presentation/widgets/widgets_menu.dart';
import 'package:card_memory_game_three/features/puntaje/data/models/modelo_puntaje.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PantallaHistorial extends StatelessWidget {
  final String nombreJugador;
  const PantallaHistorial({super.key, required this.nombreJugador});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial de $nombreJugador"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ValueListenableBuilder(
        // Escuchamos cambio en tiempo real en la caja de puntajes
        valueListenable: Hive.box<ModeloPuntaje>('caja_puntajes').listenable(),
        builder: (context, Box<ModeloPuntaje> caja, _) {
          // Logica de filtrado y ordenamiento
          // Filtrando por nombre
          final misPuntajes =
              caja.values
                  .where(
                    (s) =>
                        s.nombreJugador.toLowerCase() ==
                        nombreJugador.toLowerCase(),
                  )
                  .toList()
                ..sort((a, b) => b.fecha.compareTo(a.fecha));

          // Estado vacio
          if (misPuntajes.isEmpty) {
            return MensajeVacio(nombreJugador: nombreJugador);
          }

          // Lista de resultados
          return ListView.builder(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            itemCount: misPuntajes.length,
            itemBuilder: (context, index) {
              final item = misPuntajes[index];
              return ItemHistorial(puntaje: item);
            },
          );
        },
      ),
    );
  }
}

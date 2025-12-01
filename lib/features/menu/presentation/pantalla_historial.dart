import 'package:card_memory_game_three/features/menu/presentation/widgets/item_historial.dart';
import 'package:card_memory_game_three/features/menu/presentation/widgets/mensaje_vacio.dart';
import 'package:card_memory_game_three/features/puntaje/data/models/modelo_puntaje.dart';
import 'package:card_memory_game_three/features/puntaje/presentation/widgets/cabecera_filtro.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PantallaHistorial extends StatefulWidget {
  final String nombreJugador;
  const PantallaHistorial({super.key, required this.nombreJugador});

  @override
  State<PantallaHistorial> createState() => _PantallaHistorialState();
}

class _PantallaHistorialState extends State<PantallaHistorial> {
  // Manteniendo el idioma para filtrar
  String _idiomaActual = 'es';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial de ${widget.nombreJugador}"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Avatar y filtro de idiomas
          CabeceraFiltro(
            idiomaSeleccionado: _idiomaActual,
            alCambiarIdioma: (nuevoIdioma) {
              setState(() {
                _idiomaActual = nuevoIdioma;
              });
            },
          ),

          // Lista filtrada
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<ModeloPuntaje>(
                'caja_puntajes',
              ).listenable(),
              builder: (context, Box<ModeloPuntaje> caja, _) {
                // Filtrando la lista
                final misPuntajes = caja.values
                    .where(
                      (s) =>
                          // Verificando nombre
                          s.nombreJugador.toLowerCase() ==
                              widget.nombreJugador.toLowerCase() &&
                          s.idioma == _idiomaActual,
                    )
                    .toList();

                // Ordenando por mas reciente
                misPuntajes.sort((a, b) => b.fecha.compareTo(a.fecha));

                // Si no se encuentran resultados al filtrar mostrar vacio
                if (misPuntajes.isEmpty) {
                  return MensajeVacio(nombreJugador: widget.nombreJugador);
                }

                // Lista de resultados
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  itemCount: misPuntajes.length,
                  itemBuilder: (context, index) {
                    return ItemHistorial(puntaje: misPuntajes[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

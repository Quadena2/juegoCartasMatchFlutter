import 'package:card_memory_game_three/features/menu/presentation/widgets/item_historial.dart';
import 'package:card_memory_game_three/features/menu/presentation/widgets/mensaje_vacio.dart';
import 'package:card_memory_game_three/features/puntaje/data/models/modelo_puntaje.dart';
import 'package:card_memory_game_three/features/puntaje/data/repositories/repositorio_puntaje.dart';
import 'package:card_memory_game_three/features/puntaje/presentation/widgets/cabecera_filtro.dart';
import 'package:flutter/material.dart';


class PantallaHistorial extends StatefulWidget {
  final String nombreJugador;
  const PantallaHistorial({super.key, required this.nombreJugador});

  @override
  State<PantallaHistorial> createState() => _PantallaHistorialState();
}

class _PantallaHistorialState extends State<PantallaHistorial> {
  // Manteniendo el idioma para filtrar
  String _idiomaActual = 'es';
  final RepositorioPuntaje _repositorio = RepositorioPuntaje();
  List<ModeloPuntaje> _listaPuntajes = [];

  @override
  void initState() {
    super.initState();
    // Cargando datos 
    _cargarDatos();
  }

  void _cargarDatos(){
    // Obteniendo todos los datos de la lista
    final todosLosPuntajes = _repositorio.obtenerHistorial();

    // Filtrando idioma seleccionado y jugador
    final filtro = todosLosPuntajes.where((s) =>
        s.nombreJugador.toLowerCase() == widget.nombreJugador.toLowerCase()
        && s.idioma == _idiomaActual
    ).toList();

    // Ordenando (Order by desc)
    filtro.sort((a,b) => b.fecha.compareTo(a.fecha));

    // Actualizando
    setState(() {
      _listaPuntajes = filtro;
    },);
  }

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
              _cargarDatos();
            },
          ),

          // Lista filtrada
          Expanded(
            child: _listaPuntajes.isEmpty
              ? MensajeVacio(nombreJugador: widget.nombreJugador)
              : ListView(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                physics: const BouncingScrollPhysics(),
                children: _listaPuntajes.map((puntaje) {
                  // Creando solo los indices que existen
                  return ItemHistorial(puntaje: puntaje);
                }).toList(),
              )
          ),
        ],
      ),
    );
  }
}


import 'package:card_memory_game_three/features/puntaje/data/models/modelo_puntaje.dart';
import 'package:card_memory_game_three/features/vocabulario/data/models/modelo_vocabulario.dart';
import 'package:card_memory_game_three/core/data/datos_estaticos.dart';
import 'package:card_memory_game_three/features/juego/domain/entities/carta_juego.dart';
import 'package:card_memory_game_three/features/juego/domain/logic/logica_tablero.dart';
import 'package:flutter/material.dart';
import 'package:card_memory_game_three/core/utils/temporizador_juego.dart';
import 'package:card_memory_game_three/features/puntaje/data/repositories/repositorio_puntaje.dart';
import 'dart:async';

class ProveedorJuego extends ChangeNotifier {
  // Dependencia
  final LogicaTablero _logica = LogicaTablero();
  final RepositorioPuntaje _repositorioPuntaje = RepositorioPuntaje();
  late final TemporizadorJuego _temporizador;

  // Estado del tablero
  List<CartaJuego> cartas = [];
  List<int> indicesVolteados = [];

  // Estadisticas
  int puntaje = 0;
  int fallos = 0;
  int aciertos = 0;
  final int maximosFallos = 10;

  // Estados del juego
  bool juegoTerminado = false;
  bool procesando = false;
  bool victoria = false;

  // Variables de sesion para poder reiniciar
  late String _jugador = "";
  late String _categoria = "";
  late String _idioma = "";
  late int _tamano;

  ProveedorJuego() {
    // Calculando el puntaje cada segundo que pasa
    _temporizador = TemporizadorJuego(
      alActualizar: (){
        _calcularPuntajeDinamico();
        notifyListeners();
      }
    );
  }

  // Getters para UI (temporizador)
  int get segundosTranscurridos => _temporizador.segundos;
  bool get enPausa => _temporizador.enPausa;

  // Puntuacion dinamica (cada segundo)
  void _calcularPuntajeDinamico(){
    if(juegoTerminado || victoria) return;

    // Puntaje Final = (aciertos * 100) - (fallas * 50) - (segundos *2)
    int baseAciertos = aciertos * 100;
    int penalizacionFallos = fallos * 50;
    int penalizacionTiempo = _temporizador.segundos * 2;

    int puntajeFinal = baseAciertos - penalizacionFallos - penalizacionTiempo;

    // Evitando puntaje negativo, minimo 0
    puntaje = puntajeFinal > 0 ? puntajeFinal : 0;
  }

  Future<void> iniciarJuego(
    int tamano,
    String idCategoria,
    String idioma,
    String nombreJugador,
  ) async {
    _guardarSesion(tamano, idCategoria, idioma, nombreJugador);
    _resetearEstado();
    
    // Obteniendo los datos de la lista estatica
    List<ModeloVocabulario> datos = DatosEstaticos.obtenerVocabulario();

    // Generar tablero con logica respectiva
    cartas = _logica.generarTablero(
      tamanoCuadricula: tamano,
      idiomaObjetivo: idioma,
      idCategoria: idCategoria,
      database: datos,
    );

    notifyListeners();
  }

  // Reiniciar
  Future<void> reiniciarJuego() async {
    await iniciarJuego(_tamano, _categoria, _idioma, _jugador);
  }

  // Acciones del usuario
  void alternarPausa() {
    if (juegoTerminado || victoria) return;
    _temporizador.alternarPausa();
    notifyListeners();
  }

  bool puedeVoltear(int index) {
    if (procesando || juegoTerminado || victoria || enPausa) return false;
    if (cartas[index].estaEmparejada || indicesVolteados.contains(index))
      return false;
    return true;
  }

  void voltearCarta(int index) {
    indicesVolteados.add(index);
    if (indicesVolteados.length == 2) {
      _procesarIntento();
    }
  }

  // Logica interna
  void _procesarIntento() async {
    procesando = true;

    final idx1 = indicesVolteados[0];
    final idx2 = indicesVolteados[1];

    // Pequeña espera para que el usuario pueda ver ambas cartas antes de ser volteadas de nuevo
    await Future.delayed(const Duration(milliseconds: 300));

    if (cartas[idx1].idPareja == cartas[idx2].idPareja) {
      _manejarAcierto(idx1, idx2);
    } else {
      await _manejarFallo();
    }

    indicesVolteados.clear();
    procesando = false;
    notifyListeners();
  }

  void _manejarAcierto(int idx1, int idx2) {
    cartas[idx1].estaEmparejada = true;
    cartas[idx2].estaEmparejada = true;
    
    aciertos++;
    _calcularPuntajeDinamico();

    // Verificando si todas las cartas estan emparejadas (ganar)
    if (cartas.every((c) => c.estaEmparejada)) {
      victoria = true;
      _temporizador.detener();
      _guardarResultado();
    }
  }

  // Manejando fallos y detectando si perdio
  Future<void> _manejarFallo() async {
    fallos++;
    _calcularPuntajeDinamico();
    notifyListeners();
    // Espera adicional para que el usuario pueda ver su error
    await Future.delayed(const Duration(milliseconds: 1000));

    if (fallos >= maximosFallos) {
      juegoTerminado = true;
      _temporizador.detener();
    }
  }

  // Guardando el resultado
  Future<void> _guardarResultado() async {
    final modelo = ModeloPuntaje(
      nombreJugador: _jugador,
      puntaje: puntaje,
      fecha: DateTime.now(),
      idCategoria: _categoria,
      dificultad: "${_tamano}x${_tamano}",
      idioma: _idioma,
    );
    await _repositorioPuntaje.guardarPuntaje(modelo);
  }

  // Control de estado interno
  void _resetearEstado() {
    puntaje = 0;
    fallos = 0;
    aciertos = 0;
    juegoTerminado = false;
    victoria = false;
    indicesVolteados.clear();
    procesando = false;

    indicesVolteados.clear();
    _temporizador.iniciar();
  }

  void _guardarSesion(
    int tamano,
    String categoria,
    String idioma,
    String nombreJugador,
  ) {
    _tamano = tamano;
    _categoria = categoria;
    _idioma = idioma;
    _jugador = nombreJugador;
  }

  @override
  void dispose(){
    _temporizador.detener();
    super.dispose();
  }
}

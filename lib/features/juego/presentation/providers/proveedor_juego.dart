import 'package:card_memory_game_three/core/data/inicializador_db.dart';
import 'package:card_memory_game_three/features/puntaje/data/models/modelo_puntaje.dart';
import 'package:card_memory_game_three/features/vocabulario/data/models/modelo_vocabulario.dart';
import 'package:hive/hive.dart';
import 'package:card_memory_game_three/features/juego/domain/entities/carta_juego.dart';
import 'package:card_memory_game_three/features/juego/domain/logic/logica_tablero.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ProveedorJuego extends ChangeNotifier {
  final LogicaTablero _logica = LogicaTablero();

  // Estado del tablero
  List<CartaJuego> cartas = [];
  List<int> indicesVolteados = [];
  bool procesando = false;

  // Estadisticas
  int puntaje = 0;
  int fallos = 0;
  int aciertos = 0;
  int segundosTranscurridos = 0;
  final int maximosFallos = 5;

  // Estados del juego
  bool juegoTerminado = false;
  bool victoria = false;
  bool enPausa = false;

  Timer? _temporizador;

  // Variables de sesion para poder reiniciar
  String _jugadorGuardado = "";
  String _categoriaGuardado = "";
  String _idiomaGuardado = "";
  int _tamanoGuardado = 0;

  Future<void> iniciarJuego(
    int tamano,
    String idCategoria,
    String idioma,
    String nombreJugador,
  ) async {
    // Guardar configuracion para reiniciar
    _tamanoGuardado = tamano;
    _categoriaGuardado = idCategoria;
    _idiomaGuardado = idioma;
    _jugadorGuardado = nombreJugador;

    _resetearEstado();

    // Cargando datos de Hive (db)
    if (!Hive.isBoxOpen(InicializadorDb.CAJA_VOCABULARIO)) {
      await Hive.openBox<ModeloVocabulario>(InicializadorDb.CAJA_VOCABULARIO);
    }
    var caja = Hive.box<ModeloVocabulario>(InicializadorDb.CAJA_VOCABULARIO);
    List<ModeloVocabulario> datos = caja.values.toList();

    // Generar tablero
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
    await iniciarJuego(
      _tamanoGuardado,
      _categoriaGuardado,
      _idiomaGuardado,
      _jugadorGuardado,
    );
  }

  // Control de estado interno
  void _resetearEstado() {
    puntaje = 0;
    fallos = 0;
    aciertos = 0;
    segundosTranscurridos = 0;
    juegoTerminado = false;
    victoria = false;
    enPausa = false;
    indicesVolteados.clear();
    procesando = false;

    _temporizador?.cancel();
    _iniciarTemporizador();
  }

  void _iniciarTemporizador() {
    _temporizador = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (juegoTerminado || victoria) {
        timer.cancel();
      } else if (!enPausa) {
        segundosTranscurridos++;
        notifyListeners();
      }
    });
  }

  void alternarPausa() {
    if (juegoTerminado || victoria) return;
    enPausa = !enPausa;
    notifyListeners();
  }

  @override
  void dispose() {
    _temporizador?.cancel();
    super.dispose();
  }

  // Interaccion de cartas
  bool puedeVoltear(int index) {
    if (procesando || juegoTerminado || victoria || enPausa) return false;
    if (cartas[index].estaEmparejada) return false;
    if (indicesVolteados.contains(index)) return false;
    return true;
  }

  void voltearCarta(int index) {
    indicesVolteados.add(index);
    if (indicesVolteados.length == 2) {
      _verificarPareja();
    }
  }

  void _verificarPareja() async {
    procesando = true;
    int idx1 = indicesVolteados[0];
    int idx2 = indicesVolteados[1];

    // Dejando una espera para ver la segunda carta
    await Future.delayed(const Duration(milliseconds: 300));

    if (cartas[idx1].idPareja == cartas[idx2].idPareja) {
      // Si es Match
      cartas[idx1].estaEmparejada = true;
      cartas[idx2].estaEmparejada = true;
      puntaje += 10;
      aciertos++;

      indicesVolteados.clear();
      procesando = false;
      notifyListeners();

      // Verificar victoria total (todas match correctas)
      if (cartas.every((c) => c.estaEmparejada)) {
        victoria = true;
        _temporizador?.cancel();
        _guardarPuntajeEnDb();
        notifyListeners();
      }
    } else {
      // Fallos (no Match)
      fallos++;
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 1000));

      // Verificar si es Game Over (limite de errores superado)
      if (fallos >= maximosFallos) {
        juegoTerminado = true;
        _temporizador?.cancel();
      }

      indicesVolteados.clear();
      procesando = false;
      notifyListeners();
    }
  }

  // Persistencia de datos (db)
  Future<void> _guardarPuntajeEnDb() async {
    if (_jugadorGuardado.isEmpty) return;

    if (!Hive.isBoxOpen('caja_puntajes')) {
      await Hive.openBox<ModeloPuntaje>('caja_puntajes');
    }
    final cajaPuntajes = Hive.box<ModeloPuntaje>('caja_puntajes');

    final nuevoPuntaje = ModeloPuntaje(
      nombreJugador: _jugadorGuardado,
      puntaje: puntaje,
      fecha: DateTime.now(),
      idCategoria: _categoriaGuardado,
      dificultad: "${_tamanoGuardado}x${_tamanoGuardado}",
    );

    await cajaPuntajes.add(nuevoPuntaje);
  }
}

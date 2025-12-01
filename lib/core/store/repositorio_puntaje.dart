
// Simulando una db temporal para los puntajes, 
// al no usar db creamos una lista temporal con los puntajes
// Al ser temporal no tiene persistencia, por lo cual 
// ves que se cieere la app, los puntajes se reinician
import 'package:card_memory_game_three/models/modelo_puntaje.dart';

class RepositorioPuntaje {
  static final List<ModeloPuntaje> _historialTemporal = [];

  // Guardando
  Future<void> guardarPuntaje(ModeloPuntaje puntaje) async{
    // Agregando un pequeño retraso (delay) para simular el proceso
    await Future.delayed(const Duration(milliseconds: 100));

    _historialTemporal.add(puntaje);
  }

  // Getter del historial (Mostrar)
  List<ModeloPuntaje> obtenerHistorial(){
    return List.from(_historialTemporal);
  }
}
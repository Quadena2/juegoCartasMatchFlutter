
import 'package:hive/hive.dart';
import 'package:card_memory_game_three/features/puntaje/data/models/modelo_puntaje.dart';

// Abriendo y guardando los datos en Hive para el puntaje
class RepositorioPuntaje {
  static const String _nombreCaja = 'caja_puntajes';

  Future<void> guardarPuntaje(ModeloPuntaje puntaje) async{
    if(!Hive.isBoxOpen(_nombreCaja)){
      await Hive.openBox<ModeloPuntaje>(_nombreCaja);
    }

    final caja = Hive.box<ModeloPuntaje>(_nombreCaja);
    await caja.add(puntaje);
  }
}
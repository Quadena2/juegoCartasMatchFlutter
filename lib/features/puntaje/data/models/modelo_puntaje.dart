import 'package:hive/hive.dart';

part 'modelo_puntaje.g.dart';

@HiveType(typeId: 1)
class ModeloPuntaje extends HiveObject {
  @HiveField(0)
  final String nombreJugador;

  @HiveField(1)
  final int puntaje;

  @HiveField(2)
  final DateTime fecha;

  @HiveField(3)
  final String idCategoria;

  @HiveField(4)
  final String dificultad;

  @HiveField(5)
  final String idioma;

  ModeloPuntaje({
    required this.nombreJugador,
    required this.puntaje,
    required this.fecha,
    required this.idCategoria,
    required this.dificultad,
    this.idioma = 'es',
  });
}

class ModeloPuntaje {
  final String nombreJugador;
  final int puntaje;
  final DateTime fecha;
  final String idCategoria;
  final String dificultad;
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

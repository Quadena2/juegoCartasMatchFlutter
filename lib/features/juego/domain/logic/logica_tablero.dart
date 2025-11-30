import 'package:card_memory_game_three/features/juego/domain/entities/carta_juego.dart';
import 'package:card_memory_game_three/features/vocabulario/data/models/modelo_vocabulario.dart';

class LogicaTablero {
  // Generando lista de cartas para jugar
  List<CartaJuego> generarTablero({
    required int tamanoCuadricula,
    required String idiomaObjetivo,
    required String idCategoria,
    required List<ModeloVocabulario> database,
  }) {
    List<CartaJuego> mazo = [];
    // Filtrando db por categoria
    var vocabularioFiltrado = database
        .where((v) => v.idCategoria == idCategoria)
        .toList();

    if (vocabularioFiltrado.isEmpty) {
      // Retornando vacion si no hay datos
      return [];
    }

    // Calculando cuantas parejas caben
    int totalCeldas = tamanoCuadricula * tamanoCuadricula;
    int parejasNecesarias = (totalCeldas / 2).floor();

    // Seleccionando  palabras ()
    vocabularioFiltrado.shuffle();
    var palabrasSeleccionadas = vocabularioFiltrado
        .take(parejasNecesarias)
        .toList();

    // Creando las cartas Img - Texto
    for (var vocab in palabrasSeleccionadas) {
      // Carta con imagen
      mazo.add(
        CartaJuego(
          id: '${vocab.id}_img',
          contenido: vocab.rutaImagen,
          esImagen: true,
          idPareja: vocab.id,
        ),
      );

      // Carta con Texto (Traduccion correspondiente)
      mazo.add(
        CartaJuego(
          id: '${vocab.id}_txt',
          contenido: vocab.traducciones[idiomaObjetivo] ?? 'Error',
          esImagen: false,
          idPareja: vocab.id,
        ),
      );
    }

    // Manejo de matriz impar (incluyendo una carta bonus para rellenar)
    if (totalCeldas % 2 != 0) {
      mazo.add(
        CartaJuego(
          id: 'bonus_centro',
          contenido: 'assets/images/ui/star.png',
          esImagen: true,
          idPareja: 'bonus',
          esBonus: true,
          estaEmparejada: true,
        ),
      );
    }

    // Mezclando todo
    mazo.shuffle();

    return mazo;
  }
}

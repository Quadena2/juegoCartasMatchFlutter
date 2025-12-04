import 'package:card_memory_game_three/models/carta_juego.dart';
import 'package:card_memory_game_three/models/modelo_vocabulario.dart';

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
      // Sin datos en categoria usamos todo el contenido
      vocabularioFiltrado = List.from(database);
    }

    // Si la db esta vacia salimos
    if(vocabularioFiltrado.isEmpty) return [];

    // Calculando cuantas parejas caben
    int totalCeldas = tamanoCuadricula * tamanoCuadricula;
    int parejasNecesarias = (totalCeldas / 2).floor();

    // Correccion de freeze de pantalla
    if(vocabularioFiltrado.length < parejasNecesarias){
      int vecesARepetir = (parejasNecesarias / vocabularioFiltrado.length).ceil();
      var listaBase = List<ModeloVocabulario>.from(vocabularioFiltrado);

      for(int i=0; i< vecesARepetir; i++){
        vocabularioFiltrado.addAll(listaBase);
      }
    }

    // Seleccionando  palabras ()
    vocabularioFiltrado.shuffle();
    var palabrasSeleccionadas = vocabularioFiltrado
        .take(parejasNecesarias)
        .toList();

    // Creando las cartas Img - Texto
    for (int i=0; i<palabrasSeleccionadas.length; i++) {
      var vocab = palabrasSeleccionadas[i];
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

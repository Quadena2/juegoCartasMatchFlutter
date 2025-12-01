class ModeloVocabulario {
  final String id;
  final String rutaImagen;
  final Map<String, String> traducciones;
  final String idCategoria;

  ModeloVocabulario({
    required this.id,
    required this.rutaImagen,
    required this.traducciones,
    required this.idCategoria,
  });
}

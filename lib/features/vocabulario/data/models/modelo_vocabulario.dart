import 'package:hive/hive.dart';

part 'modelo_vocabulario.g.dart';

@HiveType(typeId: 0)
class ModeloVocabulario extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String rutaImagen;

  @HiveField(2)
  final Map<String, String> traducciones;

  @HiveField(3)
  final String idCategoria;

  ModeloVocabulario({
    required this.id,
    required this.rutaImagen,
    required this.traducciones,
    required this.idCategoria,
  });
}

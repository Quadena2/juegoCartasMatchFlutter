class CartaJuego {
  final String id;
  final String contenido;
  final bool esImagen;
  final String idPareja;
  bool estaEmparejada;
  final bool esBonus;

  CartaJuego({
    required this.id,
    required this.contenido,
    required this.esImagen,
    required this.idPareja,
    this.estaEmparejada = false,
    this.esBonus = false,
  });
}

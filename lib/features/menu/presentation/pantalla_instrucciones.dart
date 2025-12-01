import 'package:flutter/material.dart';

class PantallaInstrucciones extends StatelessWidget {
  const PantallaInstrucciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Como Jugar"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Guía Rápida",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 20),
        
              _PasoInstruccion(
                numero: "1",
                titulo: "Voltea las cartas",
                texto:
                    "Toca cualquier carta con interrogación para revelar su contenido.",
              ),
              const SizedBox(height: 15),
        
              _PasoInstruccion(
                numero: "2",
                titulo: "Encuentra la pareja",
                texto:
                    "Debes coincidir la Imagen con su Traducción correspondiente en el idioma seleccionado (Español, Ingles, Aymara).",
              ),
              const SizedBox(height: 15),
        
              _PasoInstruccion(
                numero: "3",
                titulo: "Evita errores",
                texto:
                    "Si te equivocas 10 veces, perderás la partida. ¡Memoriza bien las posiciones!",
              ),
              const SizedBox(height: 15),
        
              _PasoInstruccion(
                numero: "4", 
                titulo: "Carta ¡BONUS!", 
                texto: "En los niveles impares (3x3, 5x5) veras una carta con una estrella, esa es la carta bonús que ya cuenta como un acierto."
              ),
              const SizedBox(height: 15,),
        
              _PasoInstruccion(
                numero: "5", 
                titulo: "Puntuación", 
                texto: "Por cada carta emparejada correctamente ganas +100 puntos\nPor cada intento fallido pierdes -50 puntos\nMientras juegas, cada segundo te quita -2 puntos\nAl fina, el juego suma tus aciertos y resta tus fallas y el tiempo para obtener tu resultado final"
              ),
        
              const Divider(height: 40),
        
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.indigo.shade100),
                ),
        
                // Carta de Tip
                child: const Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.indigo),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Tip: Usa el botón de configuración (⚙️) en el menú para cambiar la dificultad y el idioma.",
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasoInstruccion extends StatelessWidget {
  final String numero;
  final String titulo;
  final String texto;

  const _PasoInstruccion({
    required this.numero,
    required this.titulo,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.orange.shade100,
          foregroundColor: Colors.orange.shade800,
          child: Text(
            numero,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(texto, style: const TextStyle(color: Colors.black87)),
            ],
          ),
        ),
      ],
    );
  }
}

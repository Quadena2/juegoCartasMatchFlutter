import 'package:flutter/material.dart';

// Configuracion de avatar y menu desplegable
class CabeceraFiltro extends StatelessWidget {
  final String idiomaSeleccionado;
  final Function(String) alCambiarIdioma;
  const CabeceraFiltro({
    super.key,
    required this.idiomaSeleccionado,
    required this.alCambiarIdioma,
  });

  // Mapa de opciones de filtrado ('en', 'es', 'ay')
  static const Map<String, String> _opcionesIdioma = {
    'es': 'Español',
    'en': 'Ingles',
    'ay': 'Aymara',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade200,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar Circular
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 40, color: Colors.indigo.shade800),
          ),
          const SizedBox(height: 20,),

          // Texto
          const Text(
            "Selección de Idioma:",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // Selector de idioma
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(15),
                value: idiomaSeleccionado,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.indigo),
                isExpanded: false,
                style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
                dropdownColor: Colors.white,
                onChanged: (value) {
                  if (value != null) alCambiarIdioma(value);
                },
                items: _opcionesIdioma.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        color: Colors.indigo.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

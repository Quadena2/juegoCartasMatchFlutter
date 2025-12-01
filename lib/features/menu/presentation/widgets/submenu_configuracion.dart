import 'package:flutter/material.dart';

class SubmenuConfiguracion extends StatefulWidget {
  final String nombreActual;
  final int dificultadActual;
  final String categoriaActual;
  final String idiomaActual;

  final Function(String, int, String, String) alGuardar;
  const SubmenuConfiguracion({
    super.key,
    required this.nombreActual,
    required this.dificultadActual,
    required this.categoriaActual,
    required this.idiomaActual,
    required this.alGuardar,
  });

  @override
  State<SubmenuConfiguracion> createState() => _SubmenuConfiguracionState();
}

class _SubmenuConfiguracionState extends State<SubmenuConfiguracion> {
  late TextEditingController _controladorNombre;
  late int _dificultad;
  late String _categoria;
  late String _idioma;

  @override
  void initState() {
    super.initState();
    _controladorNombre = TextEditingController(text: widget.nombreActual);
    _dificultad = widget.dificultadActual;
    _categoria = widget.categoriaActual;
    _idioma = widget.idiomaActual;
  }

  @override
  void dispose() {
    _controladorNombre.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Configuracion de Partida"),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Nombre
          TextField(
            controller: _controladorNombre,
            decoration: const InputDecoration(
              labelText: "Tu Nombre",
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          // Dificultad
          _SelectorSubMenu<int>(
            titulo: "Dificultad",
            valor: _dificultad,
            contenido: const {
              3: "Facil (3x3)",
              4: "Medio (4x4)",
              5: "Dificil (5x5)",
            },
            alCambiar: (v) => setState(() => _dificultad = v!),
          ),

          // Tematica
          _SelectorSubMenu(
            titulo: "Tematica",
            valor: _categoria,
            contenido: const {
              'animales': "Animales",
              'colores': "Colores",
              'numeros': "Numeros",
            },
            alCambiar: (v) => setState(() => _categoria = v!),
          ),

          // Idioma
          _SelectorSubMenu(
            titulo: "Idioma",
            valor: _idioma,
            contenido: const {'es': "Español", 'en': "Ingles", 'ay': "Aymara"},
            alCambiar: (v) => setState(() => _idioma = v!),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            widget.alGuardar(
              _controladorNombre.text.trim(),
              _dificultad,
              _categoria,
              _idioma,
            );
            Navigator.pop(context);
          },
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}

class _SelectorSubMenu<T> extends StatelessWidget {
  final String titulo;
  final T valor;
  final Map<T, String> contenido;
  final ValueChanged<T?> alCambiar;

  const _SelectorSubMenu({
    super.key,
    required this.titulo,
    required this.valor,
    required this.contenido,
    required this.alCambiar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          DropdownButton<T>(
            value: valor,
            isExpanded: true,
            onChanged: alCambiar,
            items: contenido.entries
                .map(
                  (e) => DropdownMenuItem(child: Text(e.value), value: e.key),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

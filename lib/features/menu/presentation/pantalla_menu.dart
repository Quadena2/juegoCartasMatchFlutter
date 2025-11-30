import 'package:card_memory_game_three/features/juego/presentation/pantalla_juego.dart';
import 'package:card_memory_game_three/features/juego/presentation/providers/proveedor_juego.dart';
import 'package:card_memory_game_three/features/menu/presentation/pantalla_historial.dart';
import 'package:card_memory_game_three/features/menu/presentation/widgets/widgets_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PantallaMenu extends StatefulWidget {
  const PantallaMenu({super.key});

  @override
  State<PantallaMenu> createState() => _PantallaMenuState();
}

class _PantallaMenuState extends State<PantallaMenu> {
  // Controlador para el texto del usuario
  final TextEditingController _controladorNombre = TextEditingController();

  @override
  void dispose() {
    _controladorNombre.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Principal"),
        actions: [
          IconButton(
            tooltip: "Ver historial",
            onPressed: _irAlHistorial,
            icon: const Icon(Icons.history, size: 30),
          ),
        ],
      ),

      // Usando plantillas para centrar
      body: PlantillaMenu(
        hijos: [
          // Logo y Titulo
          const EncabezadoMenu(),

          const SizedBox(height: 40),

          // Input para el nombre
          InputNombre(controlador: _controladorNombre),

          const SizedBox(height: 30),

          // Lista de botones de niveles
          ListaNiveles(alSeleccionarNivel: _iniciarJuego),
        ],
      ),
    );
  }

  // Validando nombre
  bool _validarNombre() {
    if (_controladorNombre.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor escribe tu nombre de usuario primero"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return false;
    }
    return true;
  }

  // Iniciando juego
  void _iniciarJuego(int tamano, String idCategoria, String idioma) {
    if (_validarNombre()) {
      // Configurar el provider con los datos seleccionados
      Provider.of<ProveedorJuego>(
        context,
        listen: false,
      ).iniciarJuego(
        tamano, 
        idCategoria, 
        idioma, 
        _controladorNombre.text.trim()
      );

      // Navegar a la pantalla de juego
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (_) => PantallaJuego(tamanoCuadricula: tamano),)
      );
    }
  }

  // Logica de Navegacion
  void _irAlHistorial() {
    if (_validarNombre()) {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => PantallaHistorial(nombreJugador: _controladorNombre.text.trim()) //pantalla historial
      ));
    }
  }
}

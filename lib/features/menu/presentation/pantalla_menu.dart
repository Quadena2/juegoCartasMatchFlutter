import 'package:card_memory_game_three/features/juego/presentation/pantalla_juego.dart';
import 'package:card_memory_game_three/features/juego/presentation/providers/proveedor_juego.dart';
import 'package:card_memory_game_three/features/menu/presentation/pantalla_creditos.dart';
import 'package:card_memory_game_three/features/menu/presentation/pantalla_historial.dart';
import 'package:card_memory_game_three/features/menu/presentation/pantalla_instrucciones.dart';
import 'package:card_memory_game_three/features/menu/presentation/widgets/boton_principal.dart';
import 'package:card_memory_game_three/features/menu/presentation/widgets/widgets_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PantallaMenu extends StatefulWidget {
  const PantallaMenu({super.key});

  @override
  State<PantallaMenu> createState() => _PantallaMenuState();
}

class _PantallaMenuState extends State<PantallaMenu> {
  // Estado inicial
  String _nombreJugador = "";
  int _dificultad = 3;
  String _categoria = 'animales';
  String _idioma = 'es';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Titulo del juego
                const Text(
                  "Juego de Pares",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.indigo,
                    letterSpacing: 2.0,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                // Imagen del juego
                Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.withValues(alpha: 0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                    border: Border.all(color: Colors.indigo.shade100, width: 4),
                  ),

                  child: ClipOval(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        'assets/images/ui/logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.language,
                              size: 80,
                              color: Colors.indigo,
                            ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Boton Jugar + opciones
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(15),
                            ),
                            elevation: 5,
                          ),
                          onPressed: _iniciarJuego,
                          child: const Text(
                            "Jugar",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    // Icono de opciones desplegables
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: _abrirConfiguracion,
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.indigo,
                          size: 30,
                        ),
                        tooltip: "Configurar Partida",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),

                // Boton Puntuaciones
                BotonPrincipal(
                  texto: "Puntuaciones",
                  icono: Icons.history,
                  color: Colors.indigo,
                  alPresionar: _irAlHistorial,
                ),

                // Boton Instrucciones
                BotonPrincipal(
                  texto: "Instrucciones",
                  icono: Icons.menu_book,
                  color: Colors.blueGrey,
                  alPresionar: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PantallaInstrucciones(),
                    ),
                  ),
                ),

                // Boton Creditos
                BotonPrincipal(
                  texto: "Creditos",
                  icono: Icons.info_outline,
                  color: Colors.blueGrey,
                  alPresionar: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PantallaCreditos()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Logica
  void _abrirConfiguracion() {
    showDialog(
      context: context,
      builder: (_) => SubmenuConfiguracion(
        nombreActual: _nombreJugador,
        dificultadActual: _dificultad,
        categoriaActual: _categoria,
        idiomaActual: _idioma,
        alGuardar: (nom, dif, cat, leng) {
          setState(() {
            _nombreJugador = nom;
            _dificultad = dif;
            _categoria = cat;
            _idioma = leng;
          });
        },
      ),
    );
  }

  void _iniciarJuego() {
    if (_nombreJugador.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Configura tu nombre antes de jugar"),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      _abrirConfiguracion();
      return;
    }

    // Iniciando el juego con la configuracion seleccionada
    Provider.of<ProveedorJuego>(
      context,
      listen: false,
    ).iniciarJuego(_dificultad, _categoria, _idioma, _nombreJugador);

    // Redireccionando
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PantallaJuego(tamanoCuadricula: _dificultad),
      ),
    );
  }

  void _irAlHistorial() {
    if (_nombreJugador.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Necesitamos tu nombre para mostrar tu historial"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      _abrirConfiguracion();
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PantallaHistorial(nombreJugador: _nombreJugador),
      ),
    );
  }
}

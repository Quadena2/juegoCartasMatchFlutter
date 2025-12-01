import 'package:card_memory_game_three/features/juego/presentation/pantalla_juego.dart';
import 'package:card_memory_game_three/features/juego/presentation/providers/proveedor_juego.dart';
import 'package:card_memory_game_three/features/menu/presentation/pantalla_creditos.dart';
import 'package:card_memory_game_three/features/menu/presentation/pantalla_historial.dart';
import 'package:card_memory_game_three/features/menu/presentation/pantalla_instrucciones.dart';
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
      backgroundColor: Colors.green[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Titulo del juego (Imagen)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Image.asset(
                    'assets/images/ui/titulo.png',
                    fit: BoxFit.contain,
                    height: 120,
                    errorBuilder: (context, error, stackTrace) => Text(
                      "Juego de Pares",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.indigo,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Imagen del juego
                Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.withValues(alpha: 0.2),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                    border: Border.all(color: Colors.indigo.shade100, width: 4),
                    shape: BoxShape.circle,
                  ),

                  child: ClipOval(
                    child: Transform.scale(
                      scale: 0.9,
                      child: Image.asset(
                        'assets/images/ui/logo.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.broken_image,
                          size: 80,
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Boton Jugar + opciones
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 65,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink.withValues(alpha: 0.9),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(15),
                            ),
                            elevation: 8,
                            shadowColor: Colors.pinkAccent.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          onPressed: _iniciarJuego,
                          child: const Text(
                            "Jugar",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Icono de opciones desplegables
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        color: Colors.limeAccent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.lightGreenAccent.withValues(alpha: 0.2),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: _abrirConfiguracion,
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.blueGrey,
                          size: 32,
                        ),
                        tooltip: "Configurar Partida",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),

                // Boton Puntuaciones
                BotonPrincipal(
                  texto: "Puntuaciones",
                  icono: Icons.history,
                  color: Colors.indigo[600]!,
                  alPresionar: _irAlHistorial,
                ),

                // Boton Instrucciones
                BotonPrincipal(
                  texto: "Instrucciones",
                  icono: Icons.menu_book,
                  color: Colors.orange,
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
                  color: Colors.teal[400]!,
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

import 'package:card_memory_game_three/features/juego/presentation/providers/proveedor_juego.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_memory_game_three/features/juego/presentation/providers/widgets/widgets_juego.dart';

class PantallaJuego extends StatefulWidget {
  final int tamanoCuadricula;
  const PantallaJuego({super.key, required this.tamanoCuadricula});

  @override
  State<PantallaJuego> createState() => _PantallaJuegoState();
}

class _PantallaJuegoState extends State<PantallaJuego> {
  // Banderas locales para dialogos
  bool _victoriaMostrada = false;
  bool _derrotaMostrada = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Juego ${widget.tamanoCuadricula}x${widget.tamanoCuadricula}",
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Consumer<ProveedorJuego>(
        builder: (context, proveedor, child) {
          // Logica de dialogos
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;

            if (proveedor.victoria && !_victoriaMostrada) {
              setState(() => _victoriaMostrada = true);
              DialogosJuego.mostrarVictoria(context, proveedor.puntaje, () {
                _resetearBanderas();
                proveedor.reiniciarJuego();
              });
            }

            if (proveedor.juegoTerminado && !_derrotaMostrada) {
              setState(() => _derrotaMostrada = true);
              DialogosJuego.mostrarDerrota(context, () {
                _resetearBanderas();
                proveedor.reiniciarJuego();
              });
            }
          });

          return Column(
            children: [
              // Barra superior
              BarraEstadistica(proveedor: proveedor),

              // Tablero con pausa
              Expanded(
                child: Stack(
                  children: [
                    TableroJuego(
                      tamanoCuadricula: widget.tamanoCuadricula,
                      proveedor: proveedor,
                    ),
                    if (proveedor.enPausa)
                      CapaPausa(alReanudar: proveedor.alternarPausa),
                  ],
                ),
              ),

              // Controles inferiores
              ControlesJuego(
                proveedor: proveedor, 
                alReiniciar: () => DialogosJuego.confirmarReinicio(context, () {
                  _resetearBanderas();
                  proveedor.reiniciarJuego();
                },),
              ),
            ],
          );
        },
      ),
    );
  }

  void _resetearBanderas(){
    setState(() {
      _victoriaMostrada = false;
      _derrotaMostrada = false;
    },);
  }
}

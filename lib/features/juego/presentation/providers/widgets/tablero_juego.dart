import 'package:card_memory_game_three/features/juego/presentation/providers/proveedor_juego.dart';
import 'package:card_memory_game_three/features/juego/presentation/providers/widgets/cara_carta.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

class TableroJuego extends StatefulWidget {
  final int tamanoCuadricula;
  final ProveedorJuego proveedor;
  const TableroJuego({
    super.key,
    required this.tamanoCuadricula,
    required this.proveedor,
  });

  @override
  State<TableroJuego> createState() => _TableroJuegoState();
}

class _TableroJuegoState extends State<TableroJuego> {
  final Map<int, FlipCardController> _controladores = {};

  @override
  void didUpdateWidget(covariant TableroJuego oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Escuchar cambio en el proveedor para resetear cartas visualmente
    if (widget.proveedor.indicesVolteados.isEmpty &&
        !widget.proveedor.procesando) {
      _resetearCartasVisualmente();
    }
  }

  void _resetearCartasVisualmente() {
    _controladores.forEach((index, controller) {
      // Si la carta existe en el proveedor y no es match
      if (index < widget.proveedor.cartas.length) {
        if (!widget.proveedor.cartas[index].estaEmparejada &&
            controller.state?.isFront == false) {
          controller.toggleCard();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.proveedor.cartas.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.tamanoCuadricula,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final carta = widget.proveedor.cartas[index];

          if (!_controladores.containsKey(index)) {
            _controladores[index] = FlipCardController();
          }

          // Caso Bonus
          if (carta.esBonus) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.star, color: Colors.amber, size: 40),
              ),
            );
          }

          // Carta ya emparejada
          if (carta.estaEmparejada) {
            return CaraCarta(
              carta: carta,
              esFrente: false,
              estaEmparejada: true,
            );
          }

          // Carta Jugable
          return FlipCard(
            controller: _controladores[index],
            flipOnTouch: false,
            front: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (widget.proveedor.puedeVoltear(index)) {
                  _controladores[index]!.toggleCard();
                  widget.proveedor.voltearCarta(index);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.question_mark,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
            back: CaraCarta(
              carta: carta,
              esFrente: false,
              estaEmparejada: false,
            ),
          );
        },
      ),
    );
  }
}

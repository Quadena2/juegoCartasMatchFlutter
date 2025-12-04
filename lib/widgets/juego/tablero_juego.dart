import 'package:card_memory_game_three/models/proveedor_juego.dart';
import 'package:card_memory_game_three/widgets/juego/cara_carta.dart';
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

  // Solucion a freeze a la hora de "volver a jugar" o "Jugar de nuevo"
  // RESUMEN DEL ERROR: El codigo anterior comparaba proveedor antiguo con el nuevo dentro de didUpdateWidget
  // esto falla por la igualdad, en flutter (ChangeNotifier) el objeto proveedor que se pasa al widget es una
  // referencia en memoria, al ejecutar indicesVolteados.clear() en el proveedor, la lista se vacio en esa
  // direccion de memoria, al ejecutar dudUpdateWidget tanto oldWidget.proveedor como widget.proveedor ambos
  // apuntaban a la misma instancia de memoria, por lo cual ambos estaban vacios, entonces la condicion
  // estabaLleno && estaVacio era imposible (false && true)

  // SOLUCION (Snapshot): añadiendo una variable local "_cantidadVolteadosAnterior", al ser de tipo int
  // flutter lo guarda el valor exacto del pasado, ahora con el SnapShot comparamos con el "estado presente" del proveedor
  // SINCRONIZACION: addPostFrameCallBack para ejecutar la animacion de cierre SOLO DESPUES de que flutter termine
  // de dibujar el cuadro actual asi evitando conflictos visuales (freeze)
  int _cantidadVolteadasAnterior = 0;

  @override
  void didUpdateWidget(covariant TableroJuego oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Detectando el momento exactoen que indicesVolteados pasan a estar vacio
    if (_cantidadVolteadasAnterior > 0 &&
        widget.proveedor.indicesVolteados.isEmpty &&
        !widget.proveedor.procesando) {
      // Cierro de la carta
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _cerrarCartasAbiertas();
      });
    }

    _cantidadVolteadasAnterior = widget.proveedor.indicesVolteados.length;
  }

  void _cerrarCartasAbiertas() {
    _controladores.forEach((index, controller) {
      // Verificando rango
      if (index < widget.proveedor.cartas.length) {
        final carta = widget.proveedor.cartas[index];

        // Si no es Match y esta volteada, se cierra
        if (!carta.estaEmparejada && controller.state?.isFront == false) {
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

          // Crando controlador si no existe
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
            // Key unica de la carta, asi cuando se reinicia los id's cambia y se crean nuevos desde 0
            key: ValueKey(carta.id),

            controller: _controladores[index],
            flipOnTouch: false,
            // Boca abajo
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
            // Contenido (Cara arriba)
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

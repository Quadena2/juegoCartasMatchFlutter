
import 'dart:async';
import 'package:flutter/foundation.dart';

class TemporizadorJuego {
  Timer? _reloj;
  int _segundos = 0;
  bool _enPausa = false;

  final VoidCallback alActualizar;

  TemporizadorJuego({required this.alActualizar});

  int get segundos => _segundos;
  bool get enPausa => _enPausa;

  void iniciar(){
    detener();
    _segundos = 0;
    _enPausa = false;
    _reloj = Timer.periodic(const Duration(seconds: 1), (_){
      if(!_enPausa){
        _segundos++;
        alActualizar();
      }
    });
  }

  void pausar() => _enPausa = true;
  void reanudar() => _enPausa = false;

  void alternarPausa(){
    _enPausa = !_enPausa;
  }

  void detener(){
    _reloj?.cancel();
    _reloj = null;
  }
}
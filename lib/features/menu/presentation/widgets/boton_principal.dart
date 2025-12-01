import 'package:flutter/material.dart';

class BotonPrincipal extends StatelessWidget {
  final String texto;
  final IconData icono;
  final Color color;
  final VoidCallback alPresionar;
  const BotonPrincipal({
    super.key,
    required this.texto,
    required this.icono,
    required this.color,
    required this.alPresionar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
            elevation: 4,
          ),
          icon: Icon(icono),
          onPressed: alPresionar, 
          label: Text(texto, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BotonMenu extends StatelessWidget {
  final String texto;
  final Color color;
  final IconData icono;
  final VoidCallback alPresionar;

  const BotonMenu({
    super.key,
    required this.texto,
    required this.color,
    required this.icono,
    required this.alPresionar,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
          ),
          elevation: 3,
        ),
        onPressed: alPresionar,
        icon: Icon(icono),
        label: Text(
          texto,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

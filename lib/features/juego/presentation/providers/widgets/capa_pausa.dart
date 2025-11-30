import 'package:flutter/material.dart';

class CapaPausa extends StatelessWidget {
  final VoidCallback alReanudar;

  const CapaPausa({super.key, required this.alReanudar});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.6),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_clock, size: 80, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              "Juego Pausado",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: alReanudar, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo,
              ),
              child: const Text("Reanudar")
            ),
          ],
        ),
      ),
    );
  }
}

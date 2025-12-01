import 'package:flutter/material.dart';

class PlantillaMenu extends StatelessWidget {
  final List<Widget> hijos;
  const PlantillaMenu({super.key, required this.hijos});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: hijos,
            ),
          ),
        ),
      ),
    );
  }
}

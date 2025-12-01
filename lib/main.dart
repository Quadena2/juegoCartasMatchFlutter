import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/juego/presentation/providers/proveedor_juego.dart';
import 'features/menu/presentation/pantalla_menu.dart';

void main() async {
  // Cargando UI
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MiAppJuego());
}

class MiAppJuego extends StatelessWidget {
  const MiAppJuego({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProveedorJuego())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Juego de Pares',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          useMaterial3: true,
          // Tema global
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIconColor: Colors.indigo,
          ),
          // Tema global para botones elevados
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
            ),
          ),
        ),
        home: PantallaMenu(),
      ),
    );
  }
}

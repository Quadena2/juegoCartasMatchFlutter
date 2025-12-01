import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
// Importacion de datos para la db
import 'core/data/inicializador_db.dart';
import 'features/vocabulario/data/models/modelo_vocabulario.dart';
import 'features/puntaje/data/models/modelo_puntaje.dart';

import 'features/juego/presentation/providers/proveedor_juego.dart';
import 'features/menu/presentation/pantalla_menu.dart';

void main() async {
  // Iniciando los graficos de flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Iniciando Hive (db)
  await Hive.initFlutter();
  // Registro de adaptadores para guardar los datos
  Hive.registerAdapter(ModeloVocabularioAdapter());
  Hive.registerAdapter(ModeloPuntajeAdapter());
  // Llenando con datos iniciales
  await InicializadorDb.sembrarDatos();
  // Abrir caja de puntajes para el historial
  await Hive.openBox<ModeloPuntaje>('caja_puntajes');

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

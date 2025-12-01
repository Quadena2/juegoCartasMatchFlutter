import 'package:flutter/material.dart';

class PantallaCreditos extends StatelessWidget {
  const PantallaCreditos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Creditos"),
           //       color: Colors.teal[400]!,
        backgroundColor: Colors.teal[400],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Titulo principal
            const Text(
              "Equipo de desarrollo",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 30),

            // Icono grupo
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueGrey.shade200, width: 3),
              ),
              child: const Icon(Icons.group, size: 80, color: Colors.blueGrey),
            ),

            const SizedBox(height: 15),

            // Nombre grupo
            const Text(
              "Grupo: Fluterinhos",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),

            const Text(
              "Universidad Mayor de San Andreas",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 40),
            const Divider(thickness: 1.5),
            const SizedBox(height: 20),

            // Integrantes
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Integrantes:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),

            const SizedBox(height: 15),

            const _TarjetaMiembro(
              nombre: "Chipana Orellana Blanca Nataly",
              rol: "Programadora",
              icono: Icons.code,
              nroLista: '35',
              ci: '9935586',
            ),

            const _TarjetaMiembro(
              nombre: "Guadalajara Rojas Omir Nick",
              rol: "Programador",
              icono: Icons.code,
              nroLista: '69',
              ci: '12830799',
            ),

            const _TarjetaMiembro(
              nombre: "Mamani Pita Alberth Saul",
              rol: "Tester",
              icono: Icons.bug_report,
              nroLista: '105',
              ci: '10930259',
            ),

            const _TarjetaMiembro(
              nombre: "Rivera Calani Hanssel Franco",
              rol: "Tester",
              icono: Icons.bug_report,
              nroLista: '148',
              ci: '9960241',
            ),

            const _TarjetaMiembro(
              nombre: "Salinas Guarachi José Alejandro",
              rol: "Tester",
              icono: Icons.bug_report,
              nroLista: '157',
              ci: '13846882',
            ),

            const _TarjetaMiembro(
              nombre: "Villca Yamil Luis",
              rol: "Tester",
              icono: Icons.bug_report,
              nroLista: '176',
              ci: '12894429',
            ),
          ],
        ),
      ),
    );
  }
}

class _TarjetaMiembro extends StatelessWidget {
  final String nombre;
  final String rol;
  final IconData icono;
  final String nroLista;
  final String ci;

  const _TarjetaMiembro({
    required this.nombre,
    required this.rol,
    required this.icono,
    required this.nroLista,
    required this.ci,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            backgroundColor: Colors.indigo.shade50,
            foregroundColor: Colors.indigo,
            child: Icon(icono, size: 20),
          ),
          const SizedBox(width: 15),
          // Informacion
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  rol,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "N°: $nroLista  |   CI: $ci",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.blueGrey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myappcoffe/vistas/almacen.dart';
import 'package:myappcoffe/vistas/categorias.dart';
import 'package:myappcoffe/vistas/productos.dart';
import 'package:myappcoffe/vistas/reporte.dart';
import 'package:myappcoffe/vistas/venta.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/logo.png'),
                width: 250,
              ),

              // texto STARBUCKS
              const Text(
                'STARBUCKS',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  //#32170d
                  color: Color(0xFF41714f),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(250, 50),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductosPage(),
                    ),
                  );
                },
                child: const Text('Productos'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(250, 50),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriasPage(),
                    ),
                  );
                },
                child: const Text('Categorias'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(250, 50),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AlmacenPage(),
                    ),
                  );
                },
                child: const Text('Almacen'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(250, 50),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VentaPage(),
                    ),
                  );
                },
                child: const Text('Ventas'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(250, 50),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReportePage(),
                    ),
                  );
                },
                child: const Text('Reporte de ventas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

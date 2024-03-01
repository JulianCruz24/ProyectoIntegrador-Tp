import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myappcoffe/controlador/categoria_controlador.dart';
import 'package:myappcoffe/controlador/producto_controlador.dart';

class AddProductoPage extends StatelessWidget {
  AddProductoPage({super.key});

  final TextEditingController idController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();

  final CategoriaControlador categoriaControlador = CategoriaControlador();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Producto'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(
                  labelText: 'Precio',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: categoriaController,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Categorias'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: categoriaControlador.categorias
                              .map(
                                (e) => ListTile(
                                  title: Text(e),
                                  onTap: () {
                                    categoriaController.text = e;
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    String salida = ProductoControlador().agregarProducto(
                      idController.text,
                      nombreController.text,
                      double.parse(
                        precioController.text.isEmpty
                            ? '0'
                            : precioController.text,
                      ),
                      categoriaController.text,
                    );
                    if (salida == 'Producto agregado') {
                      idController.clear();
                      nombreController.clear();
                      precioController.clear();
                      categoriaController.clear();
                    }
                  },
                  child: const Text('AGREGAR'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myappcoffe/controlador/categoria_controlador.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  State<CategoriasPage> createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  CategoriaControlador categoriaControlador = CategoriaControlador();
  TextEditingController nombreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: categoriaControlador.categorias.isEmpty
          ? const Center(
              child: Text('No hay categorías'),
            )
          : ListView.builder(
              itemCount: categoriaControlador.categorias.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categoriaControlador.categorias[index]),
                  onTap: () {
                    nombreController.text =
                        categoriaControlador.categorias[index];
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Editar Categoría'),
                          content: TextField(
                            controller: nombreController,
                            decoration: const InputDecoration(
                              labelText: 'Nombre',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                categoriaControlador.editarCategoria(
                                    index, nombreController.text);
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: const Text('Editar'),
                            ),
                            TextButton(
                              onPressed: () {
                                categoriaControlador.eliminarCategoria(index);
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: const Text('Eliminar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancelar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Agregar Categoría'),
                content: TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      categoriaControlador
                          .agregarCategoria(nombreController.text);
                      setState(() {});
                      nombreController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Agregar'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

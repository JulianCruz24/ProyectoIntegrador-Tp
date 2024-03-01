import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myappcoffe/controlador/categoria_controlador.dart';
import 'package:myappcoffe/controlador/producto_controlador.dart';
import 'package:myappcoffe/modelo/Producto.dart';

class InfoProductoPage extends StatefulWidget {
  final Producto producto;
  const InfoProductoPage({super.key, required this.producto});

  @override
  State<InfoProductoPage> createState() => _EditProductoPageState();
}

class _EditProductoPageState extends State<InfoProductoPage> {
  final ProductoControlador controlador = ProductoControlador();
  final CategoriaControlador categoriaControlador = CategoriaControlador();

  final TextEditingController idController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Producto p = widget.producto;
    idController.text = p.id.toString();
    nombreController.text = p.nombre;
    precioController.text = p.precio.toString();
    categoriaController.text = p.categoria;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informacion del Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(),
                ),
                // enabled: false,
                readOnly: true,
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
                    labelText: 'Categoria',
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
                  }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controlador.eliminarProducto(widget.producto.id);
                        Navigator.pop(context);
                      },
                      child: const Text('Eliminar'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controlador.editarProducto(
                          widget.producto.id,
                          nombreController.text,
                          double.parse(
                            precioController.text.isEmpty
                                ? '0'
                                : precioController.text,
                          ),
                          categoriaController.text,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text('Editar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

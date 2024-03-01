import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myappcoffe/controlador/producto_controlador.dart';

class AlmacenPage extends StatefulWidget {
  const AlmacenPage({super.key});

  @override
  State<AlmacenPage> createState() => _AlmacenPageState();
}

class _AlmacenPageState extends State<AlmacenPage> {
  ProductoControlador controlador = ProductoControlador();
  TextEditingController cantidadController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almacen'),
      ),
      body: controlador.productos.isEmpty
          ? const Center(
              child: Text('No hay productos'),
            )
          : ListView.builder(
              itemCount: controlador.productos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    controlador.productos[index].id.toString(),
                  ),
                  title: Text(controlador.productos[index].nombre),
                  subtitle: Text(
                    '\$${controlador.productos[index].precio}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.green[100],
                          ),
                        ),
                        onPressed: () {
                          controlador.agregarCantidad(
                            controlador.productos[index].id,
                            -1,
                          );
                          setState(() {});
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Container(
                        width: 30,
                        alignment: Alignment.center,
                        child: Text(
                          controlador.productos[index].cantidad.toString(),
                        ),
                      ),
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.green[100],
                          ),
                        ),
                        onPressed: () {
                          controlador.agregarCantidad(
                            controlador.productos[index].id,
                            1,
                          );
                          setState(() {});
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Agregar Stock'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: cantidadController,
                                decoration: const InputDecoration(
                                  labelText: 'Cantidad',
                                  border: OutlineInputBorder(),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+'),
                                  ),
                                ],
                                keyboardType: TextInputType.number,
                              ),
                              TextButton(
                                onPressed: () {
                                  controlador.agregarCantidad(
                                    controlador.productos[index].id,
                                    int.parse(cantidadController.text),
                                  );
                                  Navigator.pop(context);
                                },
                                child: const Text('Agregar'),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}

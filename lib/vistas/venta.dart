import 'package:flutter/material.dart';
import 'package:myappcoffe/controlador/venta_controller.dart';
import 'package:myappcoffe/modelo/Venta.dart';

class VentaPage extends StatefulWidget {
  const VentaPage({super.key});

  @override
  State<VentaPage> createState() => _VentaPageState();
}

class _VentaPageState extends State<VentaPage> {
  final VentaController ventaController = VentaController();
  final TextEditingController codigoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venta'),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       ventaController.eliminarVentas();
        //       setState(() {});
        //     },
        //     icon: const Icon(Icons.delete),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Código',
                      border: OutlineInputBorder(),
                    ),
                    controller: codigoController,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    String salida = ventaController.agregarProducto(
                      codigoController.text,
                      1,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(salida),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                    setState(() {});
                  },
                  child: const Text('Agregar'),
                ),
              ],
            ),
            Expanded(
              child: ventaController.productos.isEmpty
                  ? const Center(
                      child: Text('No hay productos'),
                    )
                  : ListView.builder(
                      itemCount: ventaController.productos.length,
                      itemBuilder: (context, index) {
                        var fila = ventaController.productos[index];
                        return ListTile(
                          title: Text(fila.producto.nombre),
                          subtitle: Text('\$${fila.subtotal}'),
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
                                  ventaController.agregarProducto(
                                    fila.producto.id,
                                    -1,
                                  );
                                  setState(() {});
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              Container(
                                width: 30,
                                alignment: Alignment.center,
                                child: Text(fila.cantidad.toString()),
                              ),
                              IconButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.green[100],
                                  ),
                                ),
                                onPressed: () {
                                  ventaController.agregarProducto(
                                    fila.producto.id,
                                    1,
                                  );
                                  setState(() {});
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          onTap: () {
                            ventaController.eliminarProducto(fila.producto);
                            setState(() {});
                          },
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ventaController.vaciar();
                        setState(() {});
                      },
                      child: const Text('Cancelar venta'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Venta venta = ventaController.crearVenta();

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Detalle de venta'),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Text('Id Venta #${venta.id}'),
                                    for (var fila in venta.productos)
                                      Center(
                                        child: Text(
                                          '${fila.cantidad} x ${fila.producto.nombre} = \$${fila.subtotal}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    const Divider(),
                                    Text(
                                      'Total: \$${venta.total}',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      'Fecha: ${venta.fecha.split('.')[0]}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
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
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.green[700],
                                    ),
                                  ),
                                  onPressed: () {
                                    ventaController.guardarVenta(venta);
                                    setState(() {});

                                    Navigator.pop(context);
                                  },
                                  child: const Text('Aceptar',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Cobrar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

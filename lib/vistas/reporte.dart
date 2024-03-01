import 'package:flutter/material.dart';
import 'package:myappcoffe/controlador/venta_controller.dart';

class ReportePage extends StatefulWidget {
  const ReportePage({super.key});

  @override
  State<ReportePage> createState() => _ReportePageState();
}

class _ReportePageState extends State<ReportePage> {
  VentaController ventaController = VentaController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte'),
      ),
      body: ventaController.ventas.isEmpty
          ? const Center(
              child: Text('No hay ventas'),
            )
          : ListView.builder(
              itemCount: ventaController.ventas.length,
              itemBuilder: (context, index) {
                var venta = ventaController.ventas[index];
                return ListTile(
                  title: Text('Venta #${venta.id}'),
                  subtitle: Text('Total: \$${venta.total}'),
                  trailing: Text(venta.fecha.split('.')[0]),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Venta #${venta.id}'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cerrar'),
                            ),
                          ],
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

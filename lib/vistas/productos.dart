import 'package:flutter/material.dart';
import 'package:myappcoffe/controlador/producto_controlador.dart';
import 'package:myappcoffe/vistas/addproducto.dart';
import 'package:myappcoffe/vistas/infoproducto.dart';

class ProductosPage extends StatefulWidget {
  const ProductosPage({super.key});

  @override
  State<ProductosPage> createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  ProductoControlador controlador = ProductoControlador();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        
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
                  subtitle: Text(controlador.productos[index].categoria),
                  trailing: Text(
                    controlador.productos[index].precio.toString(),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoProductoPage(
                          producto: controlador.productos[index],
                        ),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductoPage(),
            ),
          ).then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

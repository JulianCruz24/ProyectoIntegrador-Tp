import 'package:hive/hive.dart';
import 'package:myappcoffe/modelo/Producto.dart';

class ProductoControlador {
  final _productos = Hive.box('productos');

  List<Producto> get productos {
    List<Producto> lista = [];
    for (var p in _productos.values) {
      lista.add(
        Producto(
          id: p['id'],
          nombre: p['nombre'],
          precio: p['precio'],
          categoria: p['categoria'],
          cantidad: p['cantidad'],
        ),
      );
    }

    return lista;
  }

  String agregarProducto(
    String id,
    String nombre,
    double precio,
    String categoria,
  ) {
    if (_productos.containsKey(id)) return 'El producto ya existe';

    if (id.isEmpty || nombre.isEmpty || precio <= 0 || categoria.isEmpty) {
      return 'Datos incorrectos';
    }

    var producto = {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'categoria': categoria,
      'cantidad': 0,
    };

    _productos.put(id, producto);

    return 'Producto agregado';
  }

  String editarProducto(
    String id,
    String nombre,
    double precio,
    String categoria,
  ) {
    if (!_productos.containsKey(id)) return 'El producto no existe';

    if (id.isEmpty || nombre.isEmpty || precio <= 0 || categoria.isEmpty) {
      return 'Datos incorrectos';
    }

    var producto = {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'categoria': categoria,
      'cantidad': _productos.get(id)['cantidad'],
    };

    _productos.put(id, producto);

    return 'Producto editado';
  }

  String eliminarProducto(String id) {
    if (!_productos.containsKey(id)) return 'El producto no existe';

    _productos.delete(id);

    return 'Producto eliminado';
  }

  String eliminarTodo() {
    _productos.clear();
    return 'Productos eliminados';
  }

  String agregarCantidad(String id, int cantidad) {
    if (!_productos.containsKey(id)) return 'El producto no existe';

    if (_productos.get(id)['cantidad'] + cantidad < 0) {
      return 'Datos incorrectos';
    }

    var producto = {
      'id': _productos.get(id)['id'],
      'nombre': _productos.get(id)['nombre'],
      'precio': _productos.get(id)['precio'],
      'categoria': _productos.get(id)['categoria'],
      'cantidad': _productos.get(id)['cantidad'] + cantidad,
    };

    _productos.put(id, producto);

    print(_productos.get(id));

    return 'Cantidad agregada';
  }

  String eliminarCantidad(String id, int cantidad) {
    if (!_productos.containsKey(id)) return 'El producto no existe';

    if (cantidad <= 0) return 'Datos incorrectos';

    if (_productos.get(id)['cantidad'] - cantidad < 0) {
      return 'No hay suficiente cantidad';
    }

    var producto = {
      'id': _productos.get(id)['id'],
      'nombre': _productos.get(id)['nombre'],
      'precio': _productos.get(id)['precio'],
      'categoria': _productos.get(id)['categoria'],
      'cantidad': _productos.get(id)['cantidad'] - cantidad,
    };

    _productos.put(id, producto);

    return 'Cantidad eliminada';
  }
}

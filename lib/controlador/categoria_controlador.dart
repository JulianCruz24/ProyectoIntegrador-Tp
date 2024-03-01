import 'package:hive/hive.dart';

class CategoriaControlador {
  final _categoriaBox = Hive.box('categorias');

  List<dynamic> get categorias {
    List<dynamic> categorias = [];
    for (var i = 0; i < _categoriaBox.length; i++) {
      categorias.add(_categoriaBox.getAt(i));
    }
    return categorias;
  }

  String agregarCategoria(String nombre) {
    if (nombre.isEmpty) {
      return 'El nombre no puede estar vacío';
    }
    for (var i = 0; i < _categoriaBox.length; i++) {
      if (_categoriaBox.getAt(i) == nombre) {
        return 'La categoría ya existe';
      }
    }
    _categoriaBox.add(nombre);
    return 'Categoría agregada';
  }

  String editarCategoria(int index, String nombre) {
    if (nombre.isEmpty) {
      return 'El nombre no puede estar vacío';
    }
    for (var i = 0; i < _categoriaBox.length; i++) {
      if (_categoriaBox.getAt(i) == nombre && i != index) {
        return 'La categoría ya existe';
      }
    }
    _categoriaBox.putAt(index, nombre);
    return 'Categoría editada';
  }

  String eliminarCategoria(int index) {
    _categoriaBox.deleteAt(index);
    return 'Categoría eliminada';
  }
}

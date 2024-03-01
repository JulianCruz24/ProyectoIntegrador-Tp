import 'package:myappcoffe/modelo/Producto.dart';

class Venta {
  String id;
  List<FilaVenta> productos;
  double total;
  String fecha;

  Venta({
    required this.id,
    required this.productos,
    this.total = 0,
    required this.fecha,
  });

  void calcularTotal() {
    for (var fila in productos) {
      total += fila.subtotal;
    }
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'productos': productos.map((p) => p.toJson()).toList(),
      'total': total,
      'fecha': fecha,
    };
  }

  factory Venta.fromJson(Map<dynamic, dynamic> json) {
    return Venta(
      id: json['id'],
      productos: List<FilaVenta>.from(
        json['productos'].map((p) => FilaVenta.fromJson(p)),
      ),
      total: json['total'],
      fecha: json['fecha'],
    );
  }
}

class FilaVenta {
  Producto producto;
  int cantidad;

  FilaVenta({
    required this.producto,
    required this.cantidad,
  });

  double get subtotal => producto.precio * cantidad;

  Map<String, dynamic> toJson() {
    return {
      'producto': producto.toJson(),
      'cantidad': cantidad,
    };
  }

  factory FilaVenta.fromJson(Map<dynamic, dynamic> json) {
    return FilaVenta(
      producto: Producto.fromJson(json['producto']),
      cantidad: json['cantidad'],
    );
  }
}

class Producto {
  String id;
  String nombre;
  double precio;
  int cantidad;
  String categoria;

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.cantidad,
    required this.categoria,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'cantidad': cantidad,
      'categoria': categoria,
    };
  }

  factory Producto.fromJson(Map<dynamic, dynamic> json) {
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      precio: json['precio'],
      cantidad: json['cantidad'],
      categoria: json['categoria'],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaginaHome extends StatefulWidget {
  const PaginaHome({Key? key}) : super(key: key);

  @override
  _PaginaHomeState createState() => _PaginaHomeState();
}

class _PaginaHomeState extends State<PaginaHome> {
  List<Producto> productos = [];

  @override
  void initState() {
    super.initState();
    _cargarProductos();
  }

  Future<void> _cargarProductos() async {
    final response = await http.get(Uri.parse('http://18.216.45.210/api/productos'));

    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, parsea el JSON
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        productos = data.map((item) => Producto.fromJson(item)).toList();
      });
    } else {
      // Si la solicitud no fue exitosa, muestra un mensaje de error
      throw Exception('Error al cargar productos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: _swiper(),
          ),
          Container(
            height: 400,
            child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(productos[index].nombre),
                  subtitle: Text('\$${productos[index].precioVenta.toString()}'),
                  onTap: () {
                    _mostrarDetalles(productos[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _swiper() {
    return Container(
      width: double.infinity,
      height: 300,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            imagenes[index],
            fit: BoxFit.fill,
          );
        },
        itemCount: imagenes.length,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }

  void _mostrarDetalles(Producto producto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(producto.nombre),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Descripción: ${producto.descripcion}'),
              Text('Precio: \$${producto.precioVenta.toString()}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

class Producto {
  final int id;
  final String nombre;
  final String descripcion;
  final double precioVenta;

  Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precioVenta,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
  return Producto(
    id: json['id'],
    nombre: json['nombre'],
    descripcion: json['descripcion'],
    precioVenta: double.parse(json['precio_venta'].toString()),
  );
}
}


List<String> imagenes = [
  "https://www.agsa.com/cdn/shop/products/GATO2TN.jpg?v=1646768569",
  "https://www.prindusat.com/wp-content/uploads/2019/06/5261P.jpg",
  "https://multimedia.3m.com/mws/media/1026186J/sandpaper-211q-picture.jpg?width=506",
  "https://www.victormorales.cl/149-superlarge_default/juego-de-destornilladores-bahco-b219006.jpg",
];

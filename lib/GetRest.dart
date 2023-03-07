import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final url = Uri.parse("https://mi-api-rest.fly.dev/api");
  late Future<List<Producto>> productos;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Producto>>(
          future: productos,
          builder: (context, snap) {
            if (snap.hasData) {
              return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        ListTile(
                          leading: Image.network(
                            snap.data![i].img,
                            fit: BoxFit.cover,
                            width: 90,
                            height: 90,
                          ),
                          /*Text(snap.data![i].id.toString(),
                              //snap.data![i].nombre,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),*/
                          title: Text(snap.data![i].id.toString(),
                              //snap.data![i].img,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(snap.data![i].nombre,
                              //snap.data![i].precio.toString() + " pesos",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                          trailing: Text(
                              snap.data![i].precio.toString() + " pesos",
                              //snap.data![i].id.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          /*PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                  child: const Text('Editar'),
                                  value: 'editar',
                                ),
                                const PopupMenuItem(
                                  child: Text('Eliminar'),
                                  value: 'eliminar',
                                )
                              ];
                            },
                          ),*/
                        ),
                        const Divider()
                      ],
                    );
                  });
            }
            if (snap.hasError) {
              return const Center(
                child: Text("Ha habido un problema"),
              );
            }

            return const CircularProgressIndicator();
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    productos = getProductos();
  }

  Future<List<Producto>> getProductos() async {
    final res = await http.get(url); //respuesta en texto
    final lista = List.from(jsonDecode(res.body));

    List<Producto> productos = [];
    lista.forEach((element) {
      final Producto product = Producto.fromJson(element);
      productos.add(product);
    });
    return productos;
  }
}

class Producto {
  int id;
  String nombre;
  String img;
  int precio;
  String fechaCracion;

  Producto({
    required this.id,
    required this.nombre,
    required this.img,
    required this.precio,
    required this.fechaCracion,
  });

  factory Producto.fromJson(Map json) {
    return Producto(
        id: json["id"],
        nombre: json["nombre"],
        img: json["img"],
        precio: json["precio"],
        fechaCracion: json["fechaCracion"]);
  }
}

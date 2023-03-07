import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'GetRest.dart';
import 'menuLateral.dart';

void main() {
  runApp(const MyApp());
}

//30.20
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // List items = [];
  @override
  /*void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodo();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Api Rest Añadir")),
      ),
      drawer: const menulateral(),
      body: homePage(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: Text("Añadir"),
      ),
    );
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
    Navigator.push(context, route);
  }
}

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController idControllerAgregar = TextEditingController();
  TextEditingController nombreControllerAgregar = TextEditingController();
  TextEditingController imgControllerAgregar = TextEditingController();
  TextEditingController precioControllerAgregar = TextEditingController();
  TextEditingController fechaCracionControllerAgregar = TextEditingController();
  TextEditingController idControllerActualizar = TextEditingController();
  TextEditingController nombreControllerActualizar = TextEditingController();
  TextEditingController imgControllerActualizar = TextEditingController();
  TextEditingController precioControllerActualizar = TextEditingController();
  TextEditingController fechaCracionControllerActualizar =
      TextEditingController();
  TextEditingController idControllerEliminar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('CRUD'),
      )),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Center(
            child: Text("Agregar"),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: idControllerAgregar,
            decoration: InputDecoration(hintText: 'id'),
          ),
          TextField(
            controller: nombreControllerAgregar,
            decoration: InputDecoration(hintText: 'Nombre'),
          ),
          TextField(
            controller: imgControllerAgregar,
            decoration: InputDecoration(hintText: 'img url'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          TextField(
            controller: precioControllerAgregar,
            decoration: InputDecoration(hintText: 'Precio'),
          ),
          TextField(
            controller: fechaCracionControllerAgregar,
            decoration: InputDecoration(hintText: 'Dia-Mes-Año'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: Agregar, child: Text('Agregar')),
          const SizedBox(
            height: 25.0,
          ),
          Center(
            child: Text("Actualizar"),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: idControllerActualizar,
            decoration: InputDecoration(hintText: 'id'),
          ),
          TextField(
            controller: nombreControllerActualizar,
            decoration: InputDecoration(hintText: 'Nombre'),
          ),
          TextField(
            controller: imgControllerActualizar,
            decoration: InputDecoration(hintText: 'img url'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          TextField(
            controller: precioControllerActualizar,
            decoration: InputDecoration(hintText: 'Precio'),
          ),
          TextField(
            controller: fechaCracionControllerActualizar,
            decoration: InputDecoration(hintText: 'Dia-Mes-Año'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: Actualizar, child: Text('Actualizar')),
          const SizedBox(
            height: 25.0,
          ),
          Center(
            child: Text("Eliminar"),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: idControllerEliminar,
            decoration: InputDecoration(hintText: 'id'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: Eliminar, child: Text('Eliminar'))
        ],
      ),
    );
  }

  Future<void> Agregar() async {
    final id = idControllerAgregar.text;
    final nombre = nombreControllerAgregar.text;
    final img = imgControllerAgregar.text;
    final precio = precioControllerAgregar.text;
    final fechaCracion = fechaCracionControllerAgregar.text;
    final body = {
      "id": id,
      "nombre": nombre,
      "img": img,
      "precio": precio,
      "fechaCracion": fechaCracion
    };
    final url = 'https://mi-api-rest.fly.dev/api/nuevo';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      //poner esto una vez emulado en el celular
      idControllerAgregar.text = '';
      nombreControllerAgregar.text = '';
      imgControllerAgregar.text = '';
      precioControllerAgregar.text = '';
      fechaCracionControllerAgregar.text = '';
      print('Se a creado');
      showSuccesMenssageAgregar('Se a creado');
    } else {
      showErrorMenssageAgregar('A fallado la creación');
      print('A fallado la creación');
      print(response.body);
    }
  }

  void showSuccesMenssageAgregar(String message) {
    final snackBar = SnackBar(
      content: Text(message,
          style: TextStyle(color: Color.fromARGB(255, 254, 254, 254))),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMenssageAgregar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Color.fromARGB(255, 254, 254, 254)),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> Actualizar() async {
    final id = idControllerActualizar.text;
    final nombre = nombreControllerActualizar.text;
    final img = imgControllerActualizar.text;
    final precio = precioControllerActualizar.text;
    final fechaCracion = fechaCracionControllerActualizar.text;
    final body = {
      "id": id,
      "nombre": nombre,
      "img": img,
      "precio": precio,
      "fechaCracion": fechaCracion
    };
    final url = 'https://mi-api-rest.fly.dev/api/actualizar/$id';
    final uri = Uri.parse(url);
    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      //poner esto una vez emulado en el celular
      idControllerActualizar.text = '';
      nombreControllerActualizar.text = '';
      imgControllerActualizar.text = '';
      precioControllerActualizar.text = '';
      fechaCracionControllerActualizar.text = '';
      print('Se a creado');
      showSuccesMenssageActualizar('Se a Actualizado');
    } else {
      showErrorMenssageActualizar('A fallado la creación');
      print('A fallado la creación');
      print(response.body);
    }
  }

  /*void showSuccesMenssage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }*/
  void showSuccesMenssageActualizar(String message) {
    final snackBar = SnackBar(
      content: Text(message,
          style: TextStyle(color: Color.fromARGB(255, 254, 254, 254))),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMenssageActualizar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Color.fromARGB(255, 54, 174, 11)),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> Eliminar() async {
    final id = idControllerEliminar.text;
    final body = {
      "id": id,
    };
    final url = 'https://mi-api-rest.fly.dev/api/eliminar/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      //poner esto una vez emulado en el celular
      idControllerEliminar.text = '';
      /*nombreController.text = '';
      imgController.text = '';
      precioController.value = '';
      fechaCracionController.text = '';*/
      print('Se a eliminado');
      showSuccesMenssageEliminar('Se a eliminado');
    } else {
      showErrorMenssageEliminar('A fallado la eliminacion');
      print('A fallado la eliminacion');
      print(response.body);
    }
  }

  /*void showSuccesMenssage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }*/
  void showSuccesMenssageEliminar(String message) {
    final snackBar = SnackBar(
      content: Text(message,
          style: TextStyle(color: Color.fromARGB(255, 254, 254, 254))),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMenssageEliminar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Color.fromARGB(255, 4, 158, 22)),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'GetRest.dart';
import 'menuLateral.dart';

//30.20
class Eliminar extends StatelessWidget {
  const Eliminar({super.key});

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
        title: Center(child: Text("Api Rest Eliminar")),
      ),
      drawer: const menulateral(),
      body: homePage(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: Text("Eliminar"),
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
  TextEditingController idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliminar'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: idController,
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

  Future<void> Eliminar() async {
    final id = idController.text;
    final body = {
      "id": id,
    };
    final url = 'https://mi-api-rest.fly.dev/api/eliminar/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      //poner esto una vez emulado en el celular
      idController.text = '';
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

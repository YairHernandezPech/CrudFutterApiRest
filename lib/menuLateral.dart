import 'package:flutter/material.dart';

import 'actualizar.dart';
import 'eliminar.dart';
import 'main.dart';

class menulateral extends StatelessWidget {
  const menulateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,

        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'EdilsonHP',
              style: TextStyle(fontSize: 25.0, fontFamily: 'AkayaTelivigala'),
            ),
            accountEmail: Text(''),
            otherAccountsPictures: const [
              Icon(
                Icons.camera_alt_outlined,
                color: Color.fromARGB(255, 251, 250, 250),
              ),
            ],
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'img/api_perfil.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('img/Api_portada.png'),
                  opacity: 10.0),
            ),
          ),
          InkWell(
            child: const ListTile(
              leading: Icon(Icons.edit),
              title: Text('Añadir'),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext) => const MyApp()));
            },
          ),
          InkWell(
            child: const ListTile(
              leading: Icon(Icons.edit),
              title: Text('Actualizar'),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext) => const Actualizar()));
            },
          ),
          InkWell(
            child: const ListTile(
              leading: Icon(Icons.edit),
              title: Text('Eliminar'),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext) => const Eliminar()));
            },
          ),
        ],
      ),
    );
  }
}

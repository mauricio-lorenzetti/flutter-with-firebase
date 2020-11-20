import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_with_flutter/service/authentication.dart';
import 'package:firebase_with_flutter/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final String title = "EXPANDE";
  final authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<QuerySnapshot>(context);
    print(user.docs);
    for (var doc in user.docs) {
      print(doc.data());
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("expande"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                authService.signOut();
              },
            ),
          ],
        ),
        body: Column(children: [
          Center(child: Text('Contatos // Enviar Fatura')),
          ElevatedButton(
            child: Icon(Icons.camera_alt),
            onPressed: null,
          ),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF6200EE),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: (value) {
            // Respond to item press.
          },
          items: [
            BottomNavigationBarItem(
              label: 'Fatura',
              icon: Icon(Icons.line_weight),
            ),
            BottomNavigationBarItem(
              label: 'Perfil',
              icon: Icon(Icons.face),
            ),
            BottomNavigationBarItem(
                label: 'Contatos', icon: Icon(Icons.contacts)),
          ],
        ));
  }
}

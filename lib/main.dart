import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_with_flutter/service/authentication.dart';
import 'package:firebase_with_flutter/model/user.dart';
import 'package:firebase_with_flutter/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'signin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(create: (_) => AuthenticationService()),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges),
        StreamProvider<QuerySnapshot>(
            create: (context) => DatabaseService().users)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expande Telecom',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userFB = context.watch<auth.User>();

    if (userFB != null) {
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
      return Home();
    }
    return SignIn();
  }
}

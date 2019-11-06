import 'package:authentication_app/src/authentication/authentication_service.dart';
import 'package:authentication_app/src/pages/landing_page.dart';
import 'package:authentication_app/src/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: 'Authentication Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LandingPage(),
      ),
      providers: <SingleChildCloneableWidget>[
        Provider<AuthBase>.value(
          value: Auth(),
        ),
        // To expose the FirebaseUser Stream to get the login method used by the user
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        ),
      ],
    );
  }
}

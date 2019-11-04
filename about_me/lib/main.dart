import 'package:about_me/calculation_page.dart';
import 'package:about_me/home_page.dart';
import 'package:flutter/material.dart';

//void main() => runApp(MyApp());
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: CalculatePage(),
    );
  }
}

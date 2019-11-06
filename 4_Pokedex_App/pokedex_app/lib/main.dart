import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex_app/src/pages/pokemon_list_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: PokemonListPage(title: 'Pokedex'),
    );
  }
}

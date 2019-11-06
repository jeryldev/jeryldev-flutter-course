import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_app/src/widgets/custom_list_card_widget.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  var _url =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  PokemonModel pokemonModel;

  Future<void> getPokemonData() async {
    var response = await http.get(_url);
    var decodedJson = jsonDecode(response.body);
    pokemonModel = PokemonModel.fromJson(decodedJson);

    // We need to call the setState to reflect any updates and to rebuild the Widget
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pokédex',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: _buildCustomGridWidget(),
    );
  }

  Widget _buildCustomGridWidget() {
    return RefreshIndicator(
      onRefresh: () => getPokemonData(),
      child: pokemonModel == null
          ? SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                color: Colors.lightBlue.shade400,
                child: Center(
                  child: Text(
                    'Pull tab to view the list of Pokémons.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                    ),
                  ),
                ),
                height: MediaQuery.of(context).size.height,
              ),
            )
          : Container(
              color: Colors.lightBlue.shade400,
              child: ListView(
                children: pokemonModel.pokemonList
                    .map((Pokemon pokemon) =>
                        CustomListCardWidget(pokemon: pokemon))
                    .toList(),
              ),
            ),
    );
  }
}

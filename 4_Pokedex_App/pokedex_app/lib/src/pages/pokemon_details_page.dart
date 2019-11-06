import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pokedex_app/src/animation/delay_widget_display_animation.dart';
import 'package:pokedex_app/src/widgets/custom_common_header_widget.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';
import 'package:pokedex_app/src/widgets/custom_tag_widget.dart';

class PokemonDetailsPage extends StatelessWidget {
  const PokemonDetailsPage({Key key, this.pokemon}) : super(key: key);
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.lightBlue.shade400,
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              elevation: 0.0,
              color: Colors.white,
              child: Container(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildDetails(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDetails() {
    return [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Hero(
          tag: 'pokemon-${pokemon.id}',
          child: Container(
            height: 120,
            width: 120,
            child: CachedNetworkImage(
              imageUrl: pokemon.img,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              placeholder: (context, url) => Icon(
                MdiIcons.pokeball,
                size: 100,
                color: Colors.red,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
      DelayWidgetDisplayAnimation(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              CustomCommonHeaderWidget(
                  label: 'Height: ${pokemon.height}', fontSize: 18),
              SizedBox(height: 8),
              CustomCommonHeaderWidget(
                  label: 'Weight: ${pokemon.weight}', fontSize: 18),
            ],
          ),
        ),
      ),
      pokemon.type == null
          ? SizedBox(height: 0)
          : _pokemonDetailSection(
              header: 'Type',
              tagList: pokemon.type
                  .map((type) => CustomTagWidget(
                        label: type,
                        backgroundColor: Colors.amber,
                      ))
                  .toList(),
            ),
      pokemon.weaknesses == null
          ? SizedBox(height: 0)
          : _pokemonDetailSection(
              header: 'Weaknesses',
              tagList: pokemon.weaknesses
                  .map((weakness) => CustomTagWidget(
                        label: weakness,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      ))
                  .toList(),
            ),
      pokemon.prevEvolution == null
          ? SizedBox(height: 0)
          : _pokemonDetailSection(
              header: 'Previous Evolution',
              tagList: pokemon.prevEvolution
                  .map((evolution) => CustomTagWidget(
                        label: evolution.name,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                      ))
                  .toList(),
            ),
      pokemon.nextEvolution == null
          ? SizedBox(height: 0)
          : _pokemonDetailSection(
              header: 'Next Evolution',
              tagList: pokemon.nextEvolution
                  .map((evolution) => CustomTagWidget(
                        label: evolution.name,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                      ))
                  .toList(),
            )
    ];
  }

  Widget _pokemonDetailSection({String header, List<Widget> tagList}) {
    return DelayWidgetDisplayAnimation(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            CustomCommonHeaderWidget(
              label: header,
              fontSize: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                spacing: 10.0,
                children: tagList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

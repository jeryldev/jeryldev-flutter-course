import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokedex_app/src/pages/pokemon_details_page.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';
import 'package:pokedex_app/src/widgets/custom_tag_widget.dart';

class CustomListCardWidget extends StatelessWidget {
  const CustomListCardWidget({Key key, this.pokemon}) : super(key: key);
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: PokemonDetailsPage(pokemon: pokemon),
            duration: Duration(milliseconds: 500),
          ),
        );
      },
      child: Hero(
        tag: 'pokemon-${pokemon.id}',
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 0.0,
          child: Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            pokemon.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Expanded(
                            child: Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              spacing: 10.0,
                              children: pokemon.type
                                  .map((type) => CustomTagWidget(
                                        label: type,
                                        backgroundColor: Colors.amber,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:about_me_app/src/pages/details_page.dart';
import 'package:about_me_app/src/styleguide.dart';
import 'package:about_me_app/src/widgets/animation/show_up_animation.dart';
import 'package:about_me_app/src/widgets/common/custom_avatar_widget.dart';
import 'package:flutter/material.dart';

class DetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, _, __) => DetailsPage(),
          ),
        );
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Hero(
              tag: "background",
              child: Container(
                height: 0.5 * screenHeight,
                width: 0.9 * screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                    stops: [0.0, 0.8],
                    colors: [Colors.purple.shade300, Colors.deepPurple],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.7),
            child: Hero(
              tag: "image",
              child: CustomAvatarWidget(
                photoPath: "assets/images/jeryl.jpg",
                radius: 120,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48, right: 16, bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Hero(
                  tag: "name",
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      child: Text('Jeryl', style: AppTheme.heading),
                    ),
                  ),
                ),
                ShowUpAnimation(
                  child: Text(
                    "Tap to know more",
                    style: AppTheme.subHeading,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

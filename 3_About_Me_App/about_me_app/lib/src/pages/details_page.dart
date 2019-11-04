import 'package:about_me_app/src/pages/overview_page.dart';
import 'package:about_me_app/src/styleguide.dart';
import 'package:about_me_app/src/widgets/animation/show_up_animation.dart';
import 'package:about_me_app/src/widgets/common/custom_avatar_widget.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Future<bool> _onWillPop() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, _, __) => OverviewPage(),
      ),
    );
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: "background",
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.0, 0.8],
                    colors: [Colors.purple.shade300, Colors.deepPurple],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16),
                    child: IconButton(
                      iconSize: 40,
                      icon: ShowUpAnimation(child: Icon(Icons.close)),
                      color: Colors.white.withOpacity(0.9),
                      onPressed: () {
//                      Navigator.pop(context);
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder: (context, _, __) => OverviewPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: _buildDetails(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDetails() {
    return [
      Hero(
        tag: "image",
        child: CustomAvatarWidget(
          photoPath: "assets/images/jeryl.jpg",
          radius: 120,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
        child: Hero(
          tag: "name",
          child: Material(
            color: Colors.transparent,
            child: Container(
              child: Text('Jeryl', style: AppTheme.heading),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
        child: ShowUpAnimation(
          child: Text(
            'Creates Mobile Apps using Flutter SDK.',
            style: AppTheme.subHeading,
//                      overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
        child: ShowUpAnimation(
          child: Text(
            'Loves to build things, and solve problems by creating mobile applications.',
            style: AppTheme.subHeading,
//                      overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    ];
  }
}

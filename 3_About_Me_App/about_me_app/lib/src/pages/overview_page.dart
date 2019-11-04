import 'package:about_me_app/src/styleguide.dart';
import 'package:about_me_app/src/widgets/animation/show_up_animation.dart';
import 'package:about_me_app/src/widgets/details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the App?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: Text('Yes'),
              ),
            ],
          ),
        )
        // This checks for null, null is returned if we click outside the box
        ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              children: <Widget>[
                ShowUpAnimation(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("About", style: AppTheme.display1),
                        Row(
                          children: <Widget>[
                            Text("Me", style: AppTheme.display1),
                            Text(".", style: AppTheme.display1green),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: DetailsWidget(),
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

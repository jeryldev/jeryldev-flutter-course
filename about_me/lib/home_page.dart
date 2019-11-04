import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 36,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Me',
                        style: TextStyle(
                          fontSize: 36,
                        ),
                      ),
                      Text(
                        '.',
                        style: TextStyle(
                          fontSize: 36,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

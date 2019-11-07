import 'package:flutter/material.dart';
import 'package:research/src/pages/tabs/account/account_tab.dart';
import 'package:research/src/pages/tabs/activity/activities_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'My Travel Photo Journal App',
            ),
            automaticallyImplyLeading: false,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.add_location)),
                Tab(icon: Icon(Icons.account_box)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ActivitiesTab(),
              AccountTab(),
            ],
          ),
        ),
      ),
    );
  }
}

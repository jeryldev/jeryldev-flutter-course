import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:researcher_app/src/authentication/authentication_service.dart';
import 'package:researcher_app/src/pages/article/article_list.dart';
import 'package:researcher_app/src/pages/article/create_article.dart';
import 'package:researcher_app/src/pages/landing_page.dart';
import 'package:researcher_app/src/widgets/platform_alert_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> getData() async {
    // For emulator use 10.0.0.2
    // For real device connected to PC, use your computers real address
    // CMD > ipconfig
//    String url = 'http://10.0.2.2/jeryllocalhost/get_data.php';
    String url = 'http://consultants.apis.ict4d.ph/public/consultants?page=1';
    final response =
        await http.get(url, headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    print(responseBody);
    return responseBody;
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Researcher App',
        ),
      ),
      drawer: _customDrawer(context),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ArticleList(list: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 8.0,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => CreateArticle(),
          ),
        ),
      ),
    );
  }

  Future<void> _passwordReset(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      final user = Provider.of<FirebaseUser>(context);
      await auth.resetPassword(user.email);

      await PlatformAlertDialog(
        title: 'Reset Email Sent 📨',
        content: 'Please check your email for the password reset link.',
        defaultActionText: 'OK',
      ).show(context);
    } catch (err) {
      print('Error: ${err.toString()}');
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(
          maintainState: false,
          builder: (context) => LandingPage(),
        ),
      );
    } catch (err) {
      print('Error: ${err.toString()}');
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Log out',
      content: 'Are you sure you want to log out?',
      defaultActionText: 'Log out',
      cancelActionText: 'Cancel',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Widget _customDrawer(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user.displayName.toString()),
            accountEmail: Text(user.email.toString()),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl.toString()),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1541338906008-f2d4ad1b2231?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=968&q=80'),
              ),
            ),
          ),
          ListTile(
            title: Text('Reset Password'),
            onTap: () => _passwordReset(context),
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: () {
              Navigator.pop(context);
              return _confirmSignOut(context);
            },
          ),
        ],
      ),
    );
  }
}

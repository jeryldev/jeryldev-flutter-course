import 'package:complete_login_setup/src/authentication/authentication_service.dart';
import 'package:complete_login_setup/src/pages/landing_page.dart';
import 'package:complete_login_setup/src/widgets/custom_raised_button.dart';
import 'package:complete_login_setup/src/widgets/platform_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home Page',
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome!',
              style: TextStyle(fontSize: 32, color: Colors.black54),
            ),
            SizedBox(height: 64),
            CustomRaisedButton(
              color: Colors.red,
              child: Text(
                'Reset Password',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _passwordReset(context),
              borderRadius: 8.0,
            ),
            SizedBox(height: 16),
            CustomRaisedButton(
              color: Colors.red,
              child: Text(
                'Sign out',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _confirmSignOut(context),
              borderRadius: 8.0,
            ),
          ],
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

//      Navigator.of(context).pushNamed('/');
    }
  }
}

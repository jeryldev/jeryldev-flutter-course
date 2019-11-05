import 'package:authentication_app/src/custom_social_button.dart';
import 'package:authentication_app/src/email_sign_in_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: EmailSignInForm(),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                SizedBox(height: 16),
                CustomSocialButton(
                  assetPath: 'assets/images/google-logo.png',
                  color: Colors.white,
                  text: 'Sign in with Google',
                  textColor: Colors.black87,
                  onPressed: () => print('Sign in with Google'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

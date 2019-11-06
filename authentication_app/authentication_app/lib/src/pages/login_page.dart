import 'package:authentication_app/src/authentication/authentication_service.dart';
import 'package:authentication_app/src/authentication/sign_in_loading_bloc.dart';
import 'package:authentication_app/src/widgets/custom_social_button.dart';
import 'package:authentication_app/src/widgets/email_sign_in_form.dart';
import 'package:authentication_app/src/widgets/platform_exception_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key, this.bloc}) : super(key: key);
  final SignInLoadingBloc bloc;

  static Widget create(BuildContext mainContext) {
    final AuthBase auth = Provider.of<AuthBase>(mainContext);
    return Provider<SignInLoadingBloc>(
      builder: (_) => SignInLoadingBloc(auth: auth),
      child: Consumer<SignInLoadingBloc>(
        builder: (context, bloc, _) => LoginPage(
          bloc: bloc,
        ),
      ),
      // Technically, we can leave this SignInLoadingBloc open
//      dispose: (context, value) => value.dispose(),
    );
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
    } on PlatformException catch (err) {
      PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: err,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: bloc.isLoadingStream,
        initialData: false,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.green.shade300,
            body: Center(
              child: SingleChildScrollView(
                  child: _buildContent(context, snapshot.data)),
            ),
          );
        });
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          isLoading
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : Column(
                  children: <Widget>[
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: EmailSignInForm.create(context, isLoading),
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
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
          ),
        ],
      ),
    );
  }
}

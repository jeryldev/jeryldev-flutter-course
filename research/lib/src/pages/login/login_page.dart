import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:research/src/authentication/authentication_service.dart';
import 'package:research/src/blocs/sign_in_loading_bloc.dart';
import 'package:research/src/widgets/common/custom_social_button.dart';
import 'package:research/src/widgets/email_sign_in_form.dart';
import 'package:research/src/widgets/platform_exception_alert_dialog.dart';

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
          backgroundColor: Colors.blue,
          body: Center(
            child: SingleChildScrollView(
              child: _buildContent(context, snapshot.data),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                isLoading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                    : Column(
                        children: <Widget>[
                          Image.asset(
                            'images/Qorange-without.png',
                            height: 140,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Login or Register to continue.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          Card(
            child: EmailSignInForm.create(context, isLoading),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'or',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          CustomSocialButton(
            assetPath: 'images/google-logo.png',
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

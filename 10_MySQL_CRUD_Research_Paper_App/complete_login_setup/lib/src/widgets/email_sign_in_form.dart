import 'package:complete_login_setup/main.dart';
import 'package:complete_login_setup/src/authentication/authentication_service.dart';
import 'package:complete_login_setup/src/authentication/models/email_sign_in_model.dart';
import 'package:complete_login_setup/src/blocs/email_sign_in_bloc.dart';
import 'package:complete_login_setup/src/blocs/sign_in_loading_bloc.dart';
import 'package:complete_login_setup/src/pages/home_page.dart';
import 'package:complete_login_setup/src/pages/landing_page.dart';
import 'package:complete_login_setup/src/pages/login_page.dart';
import 'package:complete_login_setup/src/widgets/custom_flat_button.dart';
import 'package:complete_login_setup/src/widgets/form_submit_button.dart';
import 'package:complete_login_setup/src/widgets/platform_exception_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EmailSignInForm extends StatefulWidget {
  const EmailSignInForm({
    Key key,
    this.bloc,
    this.isLoading,
  }) : super(key: key);

  final EmailSignInBloc bloc;

  final bool isLoading;

  static Widget create(BuildContext context, bool isLoading) {
    final SignInLoadingBloc signInBloc =
        Provider.of<SignInLoadingBloc>(context);
    return Provider<EmailSignInBloc>(
      builder: (context) => EmailSignInBloc(signInBloc: signInBloc),
      child: Consumer<EmailSignInBloc>(
        builder: (BuildContext context, EmailSignInBloc bloc, _) =>
            EmailSignInForm(
          bloc: bloc,
          isLoading: isLoading,
        ),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final FocusNode _emailFieldNode = FocusNode();
  final FocusNode _passwordFieldNode = FocusNode();
  TextEditingController _emailFieldController = TextEditingController();
  TextEditingController _passwordFieldController = TextEditingController();

  @override
  void dispose() {
    _emailFieldNode.dispose();
    _passwordFieldNode.dispose();
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
      stream: widget.bloc.modelStream,
      initialData: EmailSignInModel(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final EmailSignInModel model = snapshot.data;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildChildren(context, model),
          ),
        );
      },
    );
  }

  List<Widget> _buildChildren(BuildContext context, EmailSignInModel model) {
    return [
      _buildEmailTextField(context, model),
      _buildPasswordTextField(context, model),
      SizedBox(height: 24),
      _buildSubmitButton(context, model),
      CustomFlatButton(
        buttonText: model.secondaryButtonText,
        onPressed: !widget.isLoading
            ? () {
                // Toggle the Form Type
                widget.bloc.toggleFormType();
                // Focus on the Email Field
                FocusScope.of(context).requestFocus(_emailFieldNode);
//                Navigator.of(context).push(
//                  MaterialPageRoute(
//                    builder: (context) => LandingPage(),
//                  ),
//                );
              }
            : null,
      ),
    ];
  }

  Widget _buildEmailTextField(BuildContext context, EmailSignInModel model) {
    return StreamBuilder<String>(
      stream: widget.bloc.email,
      builder: (context, snapshot) {
        return TextField(
          controller: _emailFieldController,
          focusNode: _emailFieldNode,
          onEditingComplete: () {
            _emailFieldNode.unfocus();
            FocusScope.of(context).requestFocus(_passwordFieldNode);
          },
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'example@mail.com',
            errorText: snapshot.error,
            enabled: widget.isLoading == false,
          ),
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          textInputAction: TextInputAction.next,
          onChanged: widget.bloc.changeEmail,
        );
      },
    );
  }

  Widget _buildPasswordTextField(BuildContext context, EmailSignInModel model) {
    return StreamBuilder<String>(
      stream: widget.bloc.password,
      builder: (context, snapshot) {
        return TextField(
          controller: _passwordFieldController,
          focusNode: _passwordFieldNode,
          onEditingComplete: () => _passwordFieldNode.unfocus(),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: snapshot.error,
            enabled: widget.isLoading == false,
          ),
          textInputAction: TextInputAction.done,
          onChanged: widget.bloc.changePassword,
        );
      },
    );
  }

  Future<void> _submit(BuildContext context) async {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    try {
      await widget.bloc.submit();
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            maintainState: false,
            builder: (context) => HomePage(),
          ),
        );
      }
    } on PlatformException catch (err) {
      if (err.code == 'CUSTOM_ERROR_EMAIL_NOT_YET_VERIFIED') {

        await PlatformExceptionAlertDialog(
          title: 'Confirm your email address 📧',
          exception: err,
        ).show(context);
      } else if (err.code == 'CUSTOM_ERROR_NEW_USER_EMAIL_NOT_YET_VERIFIED') {

        await PlatformExceptionAlertDialog(
          /// Get the Emoji from https://emojipedia.org/party-popper/
          title: 'You are one step away from using this app! 🎉',
          exception: err,
        ).show(context);
      } else {
        print(err);
        PlatformExceptionAlertDialog(
          title: 'Sign in failed',
          exception: err,
        ).show(context);
      }
    }
  }

  Widget _buildSubmitButton(BuildContext context, EmailSignInModel model) {
    return StreamBuilder<bool>(
      stream: widget.bloc.submitValid,
      builder: (context, snapshot) {
        return FormSubmitButton(
          text: model.primaryButtonText,
          onPressed: snapshot.data == true ? () => _submit(context) : null,
        );
      },
    );
  }
}

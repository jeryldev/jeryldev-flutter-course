import 'package:authentication_app/src/custom_flat_button.dart';
import 'package:authentication_app/src/form_submit_button.dart';
import 'package:flutter/material.dart';

class EmailSignInForm extends StatefulWidget {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final FocusNode _emailFieldNode = FocusNode();
  final TextEditingController _emailFieldController = TextEditingController();
  final FocusNode _passwordFieldNode = FocusNode();
  final TextEditingController _passwordFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _buildChildren(context),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    return [
      _buildEmailTextField(context),
      _buildPasswordTextField(context),
      SizedBox(height: 24),
      _buildSubmitButton(context),
      CustomFlatButton(
        buttonText: 'Need an account? Register',
        onPressed: () => print('register an account'),
      ),
    ];
  }

  Widget _buildEmailTextField(BuildContext context) {
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
      ),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return TextField(
      controller: _passwordFieldController,
      focusNode: _passwordFieldNode,
      onEditingComplete: () => _passwordFieldNode.unfocus(),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Password',
      ),
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return FormSubmitButton(
      text: 'Submit',
      onPressed: () => print('submit'),
    );
  }
}

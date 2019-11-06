import 'package:complete_login_setup/src/widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          ),
          height: 44,
          color: Colors.red,
          borderRadius: 8.0,
          onPressed: onPressed,
        );
}

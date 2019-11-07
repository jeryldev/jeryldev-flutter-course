import 'package:flutter/material.dart';
import 'package:research/src/widgets/common/custom_raised_button.dart';

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

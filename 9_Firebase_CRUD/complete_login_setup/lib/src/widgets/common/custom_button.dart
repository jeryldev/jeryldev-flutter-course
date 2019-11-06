import 'package:complete_login_setup/src/widgets/common/custom_raised_button.dart';
import 'package:flutter/material.dart';

class CustomButton extends CustomRaisedButton {
  CustomButton({
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
    double borderRadius,
  })  : assert(text != null),
        super(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15),
          ),
          color: color,
          onPressed: onPressed,
          borderRadius: borderRadius,
        );
}

import 'package:flutter/material.dart';
import 'package:research/src/widgets/common/custom_raised_button.dart';

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

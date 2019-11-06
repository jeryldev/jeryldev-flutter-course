import 'package:authentication_app/src/widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';

class CustomSocialButton extends CustomRaisedButton {
  CustomSocialButton({
    @required String assetPath,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(
          text != null,
          assetPath != null,
        ),
        super(
          color: color,
          onPressed: onPressed,
          borderRadius: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                assetPath,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 15.0, color: textColor),
              ),
              Opacity(
                child: Image.asset(assetPath),
                opacity: 0,
              ),
            ],
          ),
        );
}

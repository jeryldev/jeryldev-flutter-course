import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({Key key, this.buttonText, this.color, this.onPressed})
      : super(key: key);

  final String buttonText;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        this.buttonText,
        style: TextStyle(
          fontSize: 15.0,
          color: this.color,
        ),
      ),
//      splashColor: Colors.white,
//      highlightColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onPressed: this.onPressed,
    );
  }
}

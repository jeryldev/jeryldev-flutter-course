import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton({
    this.color,
    this.borderRadius: 2.0,
    this.height: 50.0,
    this.onPressed,
    this.child,
  }) : assert(
          borderRadius != null,
          height != null,
        );

  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,

      child: RaisedButton(
        child: this.child,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(this.borderRadius),
        ),
        color: this.color,
        disabledColor: this.color,
        onPressed: this.onPressed,
      ),
    );
  }
}

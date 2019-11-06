import 'package:flutter/material.dart';

class CustomCommonHeaderWidget extends StatelessWidget {
  const CustomCommonHeaderWidget(
      {Key key, this.label, this.fontWeight, this.fontSize})
      : super(key: key);
  final String label;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: fontWeight == null ? FontWeight.bold : fontWeight,
        fontSize: fontSize == null ? 24 : fontSize,
        color: Colors.black,
      ),
    );
  }
}

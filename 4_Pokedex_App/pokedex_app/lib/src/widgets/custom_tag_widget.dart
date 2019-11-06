import 'package:flutter/material.dart';

class CustomTagWidget extends StatelessWidget {
  const CustomTagWidget(
      {Key key, this.label, this.backgroundColor, this.textColor})
      : super(key: key);
  final String label;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: textColor == null ? Colors.black : textColor,
          fontSize: 18,
        ),
      ),
      onSelected: (bool) {},
      backgroundColor: backgroundColor,
    );
  }
}

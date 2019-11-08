import 'package:flutter/material.dart';

Widget customFloatingActionButton(Function function, IconData icon) {
  return FloatingActionButton(
    onPressed: function,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    backgroundColor: Colors.green,
    child: Icon(
      icon,
      size: 36,
    ),
  );
}

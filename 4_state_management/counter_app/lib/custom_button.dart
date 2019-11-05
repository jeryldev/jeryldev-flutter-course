import 'package:flutter/material.dart';

Widget customButton({@required VoidCallback func,@required IconData icon}) {
  return FloatingActionButton(
    onPressed: func,
    child: Icon(icon),
    backgroundColor: Colors.green,
    shape: RoundedRectangleBorder(),
  );
}

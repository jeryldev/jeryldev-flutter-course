import 'package:flutter/material.dart';

class CustomAvatarWidget extends StatelessWidget {
  const CustomAvatarWidget({Key key, this.photoPath, @required this.radius})
      : super(key: key);
  final String photoPath;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.blue,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(photoPath),
          ),
        ),
      ),
    );
  }
}

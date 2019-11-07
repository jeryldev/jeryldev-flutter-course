import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:complete_login_setup/src/firebase_database/models/activity_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ActivityImage extends StatelessWidget {
  const ActivityImage({Key key, this.file, this.imageURL, this.activity})
      : super(key: key);
  final File file;
  final String imageURL;
  final ActivityModel activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: activity == null
          ? widgetIdentifierCreate(file: this.file, imageURL: this.imageURL)
          : widgetIdentifierUpdate(file: this.file, imageURL: this.imageURL),
    );
  }

  widgetIdentifierCreate({File file, String imageURL, ActivityModel activity}) {
    if (file == null && imageURL == null) {
      return Container(
        height: 300,
        width: 300,
        child: Icon(Icons.camera_alt, size: 50),
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade50,
          border: Border.all(
            color: Colors.black38,
            width: 1.0,
          ),
        ),
      );
    } else if (file != null) {
      return Image.file(file, height: 300, width: 300, fit: BoxFit.fitWidth);
    }
  }

  widgetIdentifierUpdate({File file, String imageURL, ActivityModel activity}) {
    if (file == null && imageURL == null) {
      return Container(
        height: 300,
        width: 300,
        child: Icon(Icons.camera_alt, size: 50),
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade50,
          border: Border.all(
            color: Colors.black38,
            width: 1.0,
          ),
        ),
      );
    } else if (file == null && imageURL == '') {
      return Container(
        height: 300,
        width: 300,
        child: Icon(Icons.camera_alt, size: 50),
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade50,
          border: Border.all(
            color: Colors.black38,
            width: 1.0,
          ),
        ),
      );
    } else if (file != null) {
      return Image.file(file, height: 300, width: 300, fit: BoxFit.fitWidth);
    } else {
      return CachedNetworkImage(
        imageUrl: imageURL,
        imageBuilder: (context, imageProvider) => Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        placeholder: (context, url) => Container(
          height: 300,
          width: 300,
          child: Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.error,
          color: Colors.blue,
        ),
      );
    }
  }
}

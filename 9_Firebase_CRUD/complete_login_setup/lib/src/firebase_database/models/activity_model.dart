import 'package:flutter/foundation.dart';

class ActivityModel {
  ActivityModel({
    @required this.id,
    @required this.title,
    @required this.activityDate,
    @required this.description,
    @required this.isCompleted,
    this.latitude,
    this.longitude,
    this.imageURL,
    this.imagePath,
  });

  final String id;
  final String title;
  final DateTime activityDate;
  final String description;
  final bool isCompleted;
  final double latitude;
  final double longitude;
  final String imageURL;
  final String imagePath;

  factory ActivityModel.fromMap(Map<String, dynamic> data, String documentId) {
    int activityDateMilliseconds;
    data['activityDate'] == null
        ? activityDateMilliseconds = DateTime.now().millisecondsSinceEpoch
        : activityDateMilliseconds = data['activityDate'];
    return ActivityModel(
      id: documentId,
      // if it is null, then return ''
      title: data['title'] ?? '',
      activityDate:
          DateTime.fromMillisecondsSinceEpoch(activityDateMilliseconds) ??
              DateTime.now(),
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      latitude: data['latitude'] ?? 14.5409,
      longitude: data['longitude'] ?? 121.0503,
      imageURL: data['imageURL'] ?? '',
      imagePath: data['imagePath'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'activityDate': activityDate.millisecondsSinceEpoch,
      'description': description,
      'isCompleted': isCompleted,
      'latitude': latitude,
      'longitude': longitude,
      'imageURL': imageURL,
      'imagePath': imagePath,
    };
  }
}

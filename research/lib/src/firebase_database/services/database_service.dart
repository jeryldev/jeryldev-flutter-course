import 'package:complete_login_setup/src/firebase_database/models/activity_model.dart';
import 'package:complete_login_setup/src/firebase_database/services/api_path.dart';
import 'package:complete_login_setup/src/firebase_database/services/firestore_service.dart';
import 'package:flutter/foundation.dart';

abstract class DatabaseService {
  Future<void> setActivity(ActivityModel activity);

  Future<void> deleteActivity(ActivityModel activity);

  Stream<List<ActivityModel>> activitiesStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements DatabaseService {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;
  final _dbService = FirestoreService();

  Future<void> setActivity(ActivityModel activity) async =>
      await _dbService.setData(
        path: APIPath.activity(uid, activity.id),
        data: activity.toMap(),
      );

  Future<void> deleteActivity(ActivityModel activity) async =>
      await _dbService.deleteData(path: APIPath.activity(uid, activity.id));

  Stream<List<ActivityModel>> activitiesStream() => _dbService.collectionStream(
        path: APIPath.activities(uid),
        builder: (data, documentId) => ActivityModel.fromMap(data, documentId),
        sort: (firstItem, secondItem) =>
            firstItem.activityDate.compareTo(secondItem.activityDate),
      );
}

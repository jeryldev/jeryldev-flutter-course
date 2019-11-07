class APIPath {
  static String activity(String uid, String activityId) =>
      'users/$uid/activities/$activityId';

  static String activities(String uid) => 'users/$uid/activities';
}

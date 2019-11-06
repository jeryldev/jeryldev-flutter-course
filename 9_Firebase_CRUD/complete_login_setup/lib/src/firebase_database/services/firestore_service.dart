import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  //Singleton

  static final instance = FirestoreService._();

  factory FirestoreService() {
    return instance;
  }

  FirestoreService._();

  Future<void> setData(
      {@required String path, @required Map<String, dynamic> data}) async {
    final reference = Firestore.instance.document(path);
    print('$path: $data');
    await reference.setData(data);
  }

  Future<void> deleteData({@required String path}) async {
    final reference = Firestore.instance.document(path);
    print('Delete $path');
    await reference.delete();
  }

  Stream<T> documentStream<T>(
      {@required String path,
      @required T builder(Map<String, dynamic> data, String documentId)}) {
    final documentReference = Firestore.instance.document(path);
    return documentReference
        .snapshots()
        .map((snapshot) => builder(snapshot.data, snapshot.documentID));
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentId),
    int sort(T firstItem, T secondItem),
  }) {
    final collectionReference = Firestore.instance.collection(path);
    final snapshots = collectionReference.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.documents
          .map((snapshot) => builder(snapshot.data, snapshot.documentID))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }
}

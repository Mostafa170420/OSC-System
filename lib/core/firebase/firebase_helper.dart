import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllDocStream(
      String path) {
    try {
      final response = _firebaseFirestore.collection(path).snapshots();
      return response;
    } on FirebaseException catch (e) {
      print("___________Error_____________");
      rethrow;
    }
  }

  static Future<void> addDoc(
      String path, String id, Map<String, dynamic> data) async {
    try {
      await _firebaseFirestore.collection(path).doc(id).set(data);
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  static Future<void> updateDoc(
      String path, String id, Map<String, dynamic> data) async {
    try {
      await _firebaseFirestore.collection(path).doc(id).update(data);
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  static Future<void> removeDoc(String path, String id) async {
    try {
      await _firebaseFirestore.collection(path).doc(id).delete();
    } on FirebaseException catch (e) {
      rethrow;
    }
  }
}

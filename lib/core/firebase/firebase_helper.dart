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
}

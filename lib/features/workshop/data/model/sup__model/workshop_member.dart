import 'package:cloud_firestore/cloud_firestore.dart';

class WorkshopMemberModel {
  String id;
  String name;
  String academicYear;
  String collage;
  String email;
  String phone;
  List<String> attendance = [];
  WorkshopMemberModel(
      {required this.id,
      required this.name,
      required this.academicYear,
      required this.collage,
      required this.email,
      required this.phone});
  factory WorkshopMemberModel.fromFirebase({required DocumentSnapshot doc}) {
    var data = doc.data() as Map;
    return WorkshopMemberModel(
        id: doc.id,
        name: data["name"],
        academicYear: data["academic_year"],
        collage: data["collage"],
        email: data["email"],
        phone: data["phone"]);
  }
}

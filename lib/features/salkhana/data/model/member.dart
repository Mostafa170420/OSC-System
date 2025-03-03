import 'package:cloud_firestore/cloud_firestore.dart';

class SalkhanaMemberModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String academicYear;
  final String college;
  final String committee1;
  final String committee2;
  final String resultCommittee1;
  final String resultCommittee2;
  final String? rejectionReasonCommittee1;
  final String? rejectionReasonCommittee2;
  final bool emailSent;

  // Factory Constructor to create a Member object from Firestore document
  factory SalkhanaMemberModel.fromFirestore(DocumentSnapshot doc) {
    print(doc.data());
    var data = doc.data() as Map;
    return SalkhanaMemberModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      academicYear: data['academic_year'] ?? '',
      college: data['college'] ?? '',
      committee1: data['committee_1'] ?? '',
      committee2: data['committee_2'] ?? '',
      resultCommittee1: data['result_committee_1'] ?? '',
      resultCommittee2: data['result_committee_2'] ?? '',
      rejectionReasonCommittee1: data['rejection_reason_committee_1'],
      rejectionReasonCommittee2: data['rejection_reason_committee_2'],
      emailSent: data['email_sent'] ?? false,
    );
  }

  // 🔥 Convert Member object back to Firestore format
  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "academic_year": academicYear,
      "college": college,
      "committee_1": committee1,
      "committee_2": committee2,
      "result_committee_1": resultCommittee1,
      "result_committee_2": resultCommittee2,
      "rejection_reason_committee_1": rejectionReasonCommittee1,
      "rejection_reason_committee_2": rejectionReasonCommittee2,
      "email_sent": emailSent,
    };
  }

  //  Constructor
  const SalkhanaMemberModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.academicYear,
    required this.college,
    required this.committee1,
    required this.committee2,
    required this.resultCommittee1,
    required this.resultCommittee2,
    this.rejectionReasonCommittee1,
    this.rejectionReasonCommittee2,
    required this.emailSent,
  });
}

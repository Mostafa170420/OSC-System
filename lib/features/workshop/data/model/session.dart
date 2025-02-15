import 'package:osc_system/features/workshop/data/model/sup__model/session_member.dart';

class SessionModel {
  String id;
  String topic;
  List<SessionMember> students = [];
  List<String> feedback = [];
  SessionModel({required this.id, required this.topic});
}

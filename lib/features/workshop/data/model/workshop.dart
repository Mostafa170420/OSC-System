import 'package:osc_system/features/workshop/data/model/session.dart';
import 'package:osc_system/features/workshop/data/model/sup__model/workshop_member.dart';

class WorkshopModel {
  String? title;
  List<WorkshopMemberModel> members = [];
  List<SessionModel> sessions = [];
}

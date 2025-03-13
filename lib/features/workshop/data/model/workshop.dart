
import 'session.dart';
import 'sup__model/workshop_member.dart' show WorkshopMemberModel;

class WorkshopModel {
  String? title;
  List<WorkshopMemberModel> members = [];
  List<SessionModel> sessions = [];
}

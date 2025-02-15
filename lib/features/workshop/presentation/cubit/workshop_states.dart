import 'package:osc_system/features/workshop/data/model/sup__model/workshop_member.dart';

class WorkshopStates {}

class WorkshopLoading extends WorkshopStates {}

class WorkshopSuccsses extends WorkshopStates {
  List<WorkshopMemberModel> members;
  WorkshopSuccsses({required this.members});
}

import '/../features/workshop/data/model/sup__model/workshop_member.dart';
import '/../features/workshop/data/model/workshop.dart';

abstract class WorkshopRepository {
  Stream<List<WorkshopMemberModel>> watchMembers(WorkshopModel workshop);
}

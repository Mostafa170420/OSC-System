

import '../../../../core/firebase/firebase_helper.dart';
import '../../domain/repositories/workshop_repository.dart';
import '../model/sup__model/workshop_member.dart';
import '../model/workshop.dart' show WorkshopModel;

class WorkshopRepositoryImp extends WorkshopRepository {
  @override
  Stream<List<WorkshopMemberModel>> watchMembers(WorkshopModel workshop) {
    return FirebaseHelper.getAllDocStream("workshop/workshop25/members").map(
      (event) => event.docs
          .map(
            (doc) => WorkshopMemberModel.fromFirebase(doc: doc),
          )
          .toList(),
    );
  }
}

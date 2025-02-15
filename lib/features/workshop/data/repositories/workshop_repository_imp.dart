import 'package:osc_system/core/firebase/end_points.dart';
import 'package:osc_system/core/firebase/firebase_helper.dart';
import 'package:osc_system/features/workshop/data/model/sup__model/workshop_member.dart';
import 'package:osc_system/features/workshop/data/model/workshop.dart';
import 'package:osc_system/features/workshop/domain/repositories/workshop_repository.dart';

class WorkshopRepositoryImp extends WorkshopRepository {
  @override
  Stream<List<WorkshopMemberModel>> watchMembers(WorkshopModel workshop) {
    return FirebaseHelper.getAllDocStream(
            "workshop/workshop25/${EndPoints.members}")
        .map(
      (event) => event.docs
          .map(
            (doc) => WorkshopMemberModel.fromFirebase(doc: doc),
          )
          .toList(),
    );
  }
}

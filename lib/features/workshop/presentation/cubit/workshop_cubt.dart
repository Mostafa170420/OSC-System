import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/features/workshop/data/model/workshop.dart';
import 'package:osc_system/features/workshop/data/repositories/workshop_repository_imp.dart';
import 'package:osc_system/features/workshop/presentation/cubit/workshop_states.dart';

class WorkshopCubt extends Cubit<WorkshopStates> {
  WorkshopCubt() : super(WorkshopLoading());
  WorkshopRepositoryImp workshopRepositoryImp = WorkshopRepositoryImp();
  void getMembers() {
    workshopRepositoryImp.watchMembers(WorkshopModel()).listen(
      (members) {
        emit(WorkshopSuccsses(members: members));
      },
    );
  }
}

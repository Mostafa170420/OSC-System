import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/member.dart';
import '../../data/repositories/salkhana_repository_imp.dart';
import '../../domain/repositories/salkhana_repository.dart';
import 'salkhana_states.dart';

class SalkhanaCubit extends Cubit<SalkhanaStates> {
  SalkhanaCubit() : super(SalkhanaLoading());
  SalkhanaRepositoryImp salkhanaRepositoryImp = SalkhanaRepositoryImp();
  List<SalkhanaMemberModel> members = [];
  String committee = "";
  String salkhanaSeason = "Salkhana25";
  static SalkhanaCubit get(context) => BlocProvider.of(context);
  void getMembers() async {
    emit(SalkhanaLoading());
    try {
      salkhanaRepositoryImp.watchMembers(salkhanaSeason).listen(
        (event) {
          event.fold((failure) => emit(SalkhanaFailureNetwork()), (succses) {
            members = succses;
            filterMembers();
          });
        },
      );
    } on Exception catch (e) {
      emit(SalkhanaFailureNetwork());
    }
  }

  void addMember(SalkhanaMemberModel memberModel) async {
    await salkhanaRepositoryImp.addMember(memberModel, salkhanaSeason).fold(
        (failure) => emit(SalkhanaFailureFirestore()),
        (succsses) => emit(SalkhanaSuccssesFirestore()));
  }

  void removeMember(String memberId) async {
    await salkhanaRepositoryImp.removeMember(memberId, salkhanaSeason).fold(
        (failure) => emit(SalkhanaFailureFirestore()),
        (succsses) => emit(SalkhanaSuccssesFirestore()));
  }

  void updateMember(SalkhanaMemberModel memberModel) async {
    await salkhanaRepositoryImp.updateMember(memberModel, salkhanaSeason).fold(
        (failure) => emit(SalkhanaFailureFirestore()),
        (succsses) => emit(SalkhanaSuccssesFirestore()));
  }

  void changeCommittee(String committeeName) {
    committee = committeeName;
    filterMembers();
  }

  void filterMembers() {
    List<SalkhanaMemberModel> data = [];
    if (committee.isNotEmpty) {
      for (var member in members) {
        if (member.committee1 == committee || member.committee2 == committee) {
          data.add(member);
        }
        emit(SalkhanaSuccsses(members: data));
      }
    } else {
      emit(SalkhanaSuccsses(members: members));
    }
  }

  void downloadMembers() async {
    await salkhanaRepositoryImp.downloadMembersToLacal().fold(
          (fail) => emit(SalkhanaFailureFirestore()),
          (sucsses) => emit(SalkhanaSuccsses(members: members)),
        );
    emit(SalkhanaDownloadSuccsses());
  }

  void uploadMembers() async {
    await salkhanaRepositoryImp.uploadMembersToRemote().fold(
          (fail) => emit(SalkhanaFailureFirestore()),
          (sucsses) => emit(SalkhanaSuccsses(members: members)),
        );
    emit(SalkhanaUploadSuccsses());
  }

  void searchMember(String text) {
    List<SalkhanaMemberModel> data = [];
    if (text.isNotEmpty) {
      for (var member in members) {
        if (member.id.toLowerCase().startsWith(text.toLowerCase())) {
          data.add(member);
        }
      }
      emit(SalkhanaSuccsses(members: data));
    } else {
      filterMembers();
    }
  }
}

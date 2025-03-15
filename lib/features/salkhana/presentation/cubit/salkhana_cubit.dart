import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/member.dart';
import '../../domain/repositories/salkhana_repository.dart';
import 'salkhana_states.dart';

class SalkhanaCubit extends Cubit<SalkhanaStates> {
  SalkhanaCubit({required this.salkhanaRepository}) : super(SalkhanaLoading());
  SalkhanaRepository salkhanaRepository;
  List<SalkhanaMemberModel> members = [];
  String committee = "";
  String salkhanaSeason = "Salkhana25";
  static SalkhanaCubit get(context) => BlocProvider.of(context);
  void getMembers() async {
    emit(SalkhanaLoading());
    salkhanaRepository.watchMembers(salkhanaSeason).fold(
        (failure) => emit(SalkhanaFailureNetwork()),
        (succsses) => succsses.listen(
              (data) {
                members = data;
                filterMembers();
              },
            ));
  }

  void addMember(SalkhanaMemberModel memberModel) async {
    await salkhanaRepository.addMember(memberModel, salkhanaSeason).fold(
        (failure) => emit(SalkhanaFailureFirestore()),
        (succsses) => emit(SalkhanaSuccssesFirestore()));
  }

  void removeMember(String memberId) async {
    await salkhanaRepository.removeMember(memberId, salkhanaSeason).fold(
        (failure) => emit(SalkhanaFailureFirestore()),
        (succsses) => emit(SalkhanaSuccssesFirestore()));
  }

  void updateMember(SalkhanaMemberModel memberModel) async {
    await salkhanaRepository.updateMember(memberModel, salkhanaSeason).fold(
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
        if (member.committee1 == committee || member.committee2 == committee)
          data.add(member);
        emit(SalkhanaSuccsses(members: data));
      }
    } else {
      emit(SalkhanaSuccsses(members: members));
    }
  }

  void searshMember(String text) {
    List<SalkhanaMemberModel> data = [];
    if (text.isNotEmpty) {
      for (var member in members) {
        if (member.name.toLowerCase().startsWith(text.toLowerCase())) {
          data.add(member);
        }
      }
      emit(SalkhanaSuccsses(members: data));
    } else {
      filterMembers();
    }
  }
}

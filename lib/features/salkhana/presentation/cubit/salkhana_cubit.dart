import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../data/model/member.dart';
import '../../domain/repositories/salkhana_repository.dart';
import 'salkhana_states.dart';



class SalkhanaCubit extends Cubit<SalkhanaStates> {
  SalkhanaCubit({required this.salkhanaRepository}) : super(SalkhanaLoading());
  SalkhanaRepository salkhanaRepository;
  String salkhanaSeason = "Salkhana25";
  static SalkhanaCubit get(context) => BlocProvider.of(context);
  void getMembers() async {
    salkhanaRepository.watchMembers(salkhanaSeason).fold(
        (failure) => emit(SalkhanaFailureNetwork()),
        (succsses) => succsses.listen(
              (members) => emit(SalkhanaSuccsses(members: members)),
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
}

import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osc_system/core/errors/failure.dart';
import 'package:osc_system/features/salkhana/data/model/member.dart';
import 'package:osc_system/features/salkhana/domain/repositories/salkhana_repository.dart';
import 'package:osc_system/features/salkhana/presentation/cubit/salkhana_states.dart';

class SalkhanaCubit extends Cubit<SalkhanaStates> {
  SalkhanaCubit({required this.salkhanaRepository}) : super(SalkhanaLoading());
  SalkhanaRepository salkhanaRepository;
  String salkhanaSeason = "Salkhana25";
  static SalkhanaCubit get(context) => BlocProvider.of(context);
  void getMembers() async {
    salkhanaRepository.watchMembers(salkhanaSeason).fold(
        (failure) => emit(SalkhanaFailureNetwork()),
        (sucsses) => sucsses.listen(
              (members) => emit(SalkhanaSucsses(members: members)),
            ));
  }

  void addMember(SalkhanaMemberModel memberModel) async {
    await salkhanaRepository.addMember(memberModel, salkhanaSeason).fold(
        (failure) => emit(SalkhanaFailureFirestore()),
        (sucsses) => emit(SalkhanaSucssesFirestore()));
  }

  void removeMember(String memberId) async {
    await salkhanaRepository.removeMember(memberId, salkhanaSeason).fold(
        (failure) => emit(SalkhanaFailureFirestore()),
        (sucsses) => emit(SalkhanaSucssesFirestore()));
  }

  void updateMember(SalkhanaMemberModel memberModel) async {
    await salkhanaRepository.updateMember(memberModel, salkhanaSeason).fold(
        (failure) => emit(SalkhanaFailureFirestore()),
        (sucsses) => emit(SalkhanaSucssesFirestore()));
  }
}

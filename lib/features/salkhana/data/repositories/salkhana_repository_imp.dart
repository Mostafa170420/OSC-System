import 'package:either_dart/either.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/firebase/end_points.dart';
import '../../../../core/firebase/firebase_helper.dart';
import '/../features/salkhana/data/model/member.dart';
import '/../features/salkhana/domain/repositories/salkhana_repository.dart';

class SalkhanaRepositoryImp extends SalkhanaRepository {
  @override
  Future<Either<Failure, void>> addMember(
      SalkhanaMemberModel memberModel, String salkhanaSeason) async {
    try {
      await SupabaseHelper.addDoc(
          "salkhana/$salkhanaSeason/${EndPoints.salkhanaMembers}",
          memberModel.id,
          memberModel.toFirestore());
      return Right(0);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, void>> removeMember(
      String memberId, String salkhanaSeason) async {
    try {
      await SupabaseHelper.removeDoc(
        "salkhana/$salkhanaSeason/${EndPoints.salkhanaMembers}",
        memberId,
      );
      return Right(0);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, void>> updateMember(
      SalkhanaMemberModel memberModel, String salkhanaSeason) async {
    try {
      await SupabaseHelper.updateDoc(
          "salkhana/$salkhanaSeason/${EndPoints.salkhanaMembers}",
          memberModel.id,
          memberModel.toFirestore());
      return Right(0);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Stream<List<SalkhanaMemberModel>>>> watchMembers(
      String salkhanaSeason) async {
    if (await InternetConnectionChecker.instance.hasConnection) {
      return Right(
        SupabaseHelper.getAllDocStream("").map((data) =>
            data.map((e) => SalkhanaMemberModel.fromFirestore(e)).toList()),
      );
    } else {
      return Left(Failure());
    }
  }
}

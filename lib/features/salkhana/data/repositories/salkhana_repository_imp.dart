import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:osc_system/core/firebase/firebase_helper.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/firebase/end_points.dart';
import '/../features/salkhana/data/model/member.dart';
import '/../features/salkhana/domain/repositories/salkhana_repository.dart';

class SalkhanaRepositoryImp extends SalkhanaRepository {
  @override
  Future<Either<Failure, void>> addMember(
      SalkhanaMemberModel memberModel, String salkhanaSeason) async {
    try {
      await FirebaseHelper.addDoc(
          "salkhana/$salkhanaSeason/${EndPoints.salkhanaMembers}",
          memberModel.id,
          memberModel.toFirestore());
      return Right(0);
    } on FirebaseException catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, void>> removeMember(
      String memberId, String salkhanaSeason) async {
    try {
      await FirebaseHelper.removeDoc(
        "salkhana/$salkhanaSeason/${EndPoints.salkhanaMembers}",
        memberId,
      );
      return Right(0);
    } on FirebaseException catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, void>> updateMember(
      SalkhanaMemberModel memberModel, String salkhanaSeason) async {
    try {
      await FirebaseHelper.updateDoc(
          "salkhana/$salkhanaSeason/${EndPoints.salkhanaMembers}",
          memberModel.id,
          memberModel.toFirestore());
      return Right(0);
    } on FirebaseException catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Stream<List<SalkhanaMemberModel>>>> watchMembers(
      String salkhanaSeason) async {
    if (await InternetConnectionChecker.instance.hasConnection) {
      return Right(FirebaseHelper.getAllDocStream(
              "salkhana/Salkhana25/${EndPoints.salkhanaMembers}")
          .map((event) => event.docs
              .map(
                (doc) => SalkhanaMemberModel.fromFirestore(doc),
              )
              .toList()));
    } else {
      return Left(Failure());
    }
  }
}

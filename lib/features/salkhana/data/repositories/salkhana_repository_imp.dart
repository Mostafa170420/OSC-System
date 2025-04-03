import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/either.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/firebase/end_points.dart';
import '../../../../core/firebase/firebase_helper.dart';
import '/../features/salkhana/data/model/member.dart';
import '/../features/salkhana/domain/repositories/salkhana_repository.dart';

class SalkhanaRepositoryImp extends SalkhanaRepository {
  final Connectivity connectivity = Connectivity();
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
  Stream<Either<Failure, List<SalkhanaMemberModel>>> watchMembers(
      String salkhanaSeason) async* {
    StreamSubscription? supabaseStreamSubscription;

    await for (var connection in connectivity.onConnectivityChanged) {
      if (connection == ConnectivityResult.none) {
        yield Left(Failure());

        await supabaseStreamSubscription?.cancel();
        supabaseStreamSubscription = null;
      } else {
        yield* Stream<Either<Failure, List<SalkhanaMemberModel>>>.multi(
            (controller) async {
          try {
            await supabaseStreamSubscription?.cancel();

            supabaseStreamSubscription =
                SupabaseHelper.getAllDocStream("").listen(
              (event) {
                final members = event
                    .map((e) => SalkhanaMemberModel.fromFirestore(e))
                    .toList();
                controller.add(Right(members));
              },
              onError: (error) {
                controller.add(Left(Failure()));
              },
              onDone: () {
                controller.close();
              },
            );
          } catch (e) {
            controller.add(Left(Failure()));
          }
        });
      }
    }
  }
}

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/either.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/database/hive_helper.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/firebase/end_points.dart';
import '../../../../core/firebase/firebase_helper.dart';
import '/../features/salkhana/data/model/member.dart';
import '/../features/salkhana/domain/repositories/salkhana_repository.dart';

class SalkhanaRepositoryImp extends SalkhanaRepository {
  final Connectivity connectivity = Connectivity();
  final InternetConnectionChecker internetConnection1 =
      InternetConnectionChecker.createInstance();
  bool? internet;
  @override
  Future<Either<Failure, void>> downloadMembersToLacal() async {
    List<SalkhanaMemberModel> members = [];
    await getRemoteMembers().fold((fail) {
      return Left(Failure());
    }, (response) => members = response);
    await removeAllMembersfromLocal().fold((fail) {
      return Left(Failure());
    }, (sucsses) {});
    await addAllMembersToLocal(members).fold((fail) {
      return Left(Failure());
    }, (Sucsses) {
      return Right(0);
    });
    return Left(Failure());
  }

  @override
  Future<Either<Failure, void>> uploadMembersToRemote() async {
    List<SalkhanaMemberModel> members = [];
    await getLocalMembers().fold((fail) {
      return Left(Failure());
    }, (response) => members = response);
    await removeAllMembersFromRemote().fold((fail) {
      return Left(Failure());
    }, (sucsses) {});
    await addAllMembersToRemote(members).fold((fail) {
      return Left(Failure());
    }, (Sucsses) {
      return Right(0);
    });
    return Left(Failure());
  }

  @override
  Future<Either<Failure, void>> addMember(
      SalkhanaMemberModel memberModel, String salkhanaSeason) async {
    try {
      if (internet ?? await setInternetState()) {
        await SupabaseHelper.addDoc(
            "salkhana/$salkhanaSeason/${EndPoints.salkhanaMembers}",
            memberModel.id,
            memberModel.toFirestore());
        return Right(0);
      } else {
        HiveHelper.addMember(memberModel);
        return Right(0);
      }
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, void>> removeMember(
      String memberId, String salkhanaSeason) async {
    try {
      if (internet ?? await setInternetState()) {
        await SupabaseHelper.removeDoc(
          "salkhana/$salkhanaSeason/${EndPoints.salkhanaMembers}",
          memberId,
        );
        return Right(0);
      } else {
        HiveHelper.removeMember(memberId);
        return Right(0);
      }
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, void>> updateMember(
      SalkhanaMemberModel memberModel, String salkhanaSeason) async {
    try {
      if (internet ?? await setInternetState()) {
        await SupabaseHelper.updateDoc(
            "salkhana/$salkhanaSeason/${EndPoints.salkhanaMembers}",
            memberModel.id,
            memberModel.toFirestore());
        return Right(0);
      } else {
        HiveHelper.addMember(memberModel);
        return Right(0);
      }
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Stream<Either<Failure, List<SalkhanaMemberModel>>> watchMembers(
      String salkhanaSeason) async* {
    if (internet ?? await setInternetState()) {
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
    } else {
      yield await getLocalMembers();
      yield* HiveHelper.watchMembers().map((event) {
        final members = HiveHelper.box.values.toList();
        return Right(
            members); // Wrap the list in Either<Failure, List<SalkhanaMemberModel>>
      });
    }
  }

  Future<Either<Failure, void>> removeAllMembersfromLocal() async {
    try {
      HiveHelper.removeAll();
      return Right(0);
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, void>> removeAllMembersFromRemote() async {
    try {
      await SupabaseHelper.removeAllDocs();
      return Right(0);
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, void>> addAllMembersToLocal(
      List<SalkhanaMemberModel> members) async {
    try {
      HiveHelper.addAllMembers(members);
      return Right(0);
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, void>> addAllMembersToRemote(
      List<SalkhanaMemberModel> members) async {
    try {
      List<Map<String, dynamic>>? membersData;
      membersData = List.from(members
          .map(
            (e) => e.toFirestore(),
          )
          .toList());
      await SupabaseHelper.addAllDocs(membersData);
      return Right(0);
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, List<SalkhanaMemberModel>>> getRemoteMembers() async {
    try {
      return Right((await SupabaseHelper.getDocs() as List)
          .map(
            (e) => SalkhanaMemberModel.fromFirestore(e),
          )
          .toList());
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, List<SalkhanaMemberModel>>> getLocalMembers() async {
    try {
      return Right(HiveHelper.getMembers());
    } catch (e) {
      print(e);
      return Left(Failure());
    }
  }

  Future<bool> setInternetState() async {
    final InternetConnectionChecker internetConnection =
        InternetConnectionChecker.createInstance();
    internet = await internetConnection.hasConnection;
    return internet!;
  }
}

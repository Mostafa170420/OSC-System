import 'package:either_dart/either.dart';

import '../../../../core/errors/failure.dart';
import '/../features/salkhana/data/model/member.dart';

abstract class SalkhanaRepository {
  // watch members
  Future<Either<Failure, Stream<List<SalkhanaMemberModel>>>> watchMembers(
      String salkhanaSeason);
  // add new member
  Future<Either<Failure, void>> addMember(
      SalkhanaMemberModel memberModel, String salkhanaSeason);
  // update member
  Future<Either<Failure, void>> updateMember(
      SalkhanaMemberModel memberModel, String salkhanaSeason);
  // remove member
  Future<Either<Failure, void>> removeMember(
      String memberId, String salkhanaSeason);
}

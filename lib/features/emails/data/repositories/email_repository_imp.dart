import 'package:either_dart/src/either.dart';
import 'package:osc_system/core/api/api_consumer.dart';
import 'package:osc_system/core/api/end_point.dart';

import 'package:osc_system/core/errors/failure.dart';
import 'package:osc_system/features/salkhana/data/model/member.dart';

import '../../domain/repositories/email_repository.dart';

class EmailRepositoryImp extends EmailRepository {
  ApiConsumer api;
  EmailRepositoryImp({required this.api});
  @override
  Future<Either<Failure, void>> sendEmail(SalkhanaMemberModel member) async {
    try {
      await api.post(EndPoint.sendEmail,
          data: {"name": member.name, "email": member.email});
      return Right(0);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, void>> sendEmails(
      List<SalkhanaMemberModel> members) async {
    try {
      for (var member in members) {
        await sendEmail(member);
      }
      return Right(0);
    } on Exception catch (e) {
      return Left(Failure());
    }
  }
}

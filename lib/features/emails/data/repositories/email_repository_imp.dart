import 'package:either_dart/src/either.dart';

import 'package:osc_system/core/errors/failure.dart';

import '../../domain/repositories/email_repository.dart';

class EmailRepositoryImp extends EmailRepository {
  @override
  Future<Either<Failure, void>> sendEmail() {
    // TODO: implement sendEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> sendEmails() {
    // TODO: implement sendEmails
    throw UnimplementedError();
  }
}

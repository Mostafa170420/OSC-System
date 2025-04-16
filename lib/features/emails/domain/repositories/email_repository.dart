import 'dart:ffi';

import 'package:either_dart/either.dart';
import 'package:osc_system/core/errors/failure.dart';

abstract class EmailRepository {
  Future<Either<Failure, void>> sendEmail();
  Future<Either<Failure, void>> sendEmails();
}

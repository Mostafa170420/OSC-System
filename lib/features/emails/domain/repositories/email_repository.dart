import 'dart:ffi';

import 'package:either_dart/either.dart';
import 'package:osc_system/core/errors/failure.dart';

import '../../../salkhana/data/model/member.dart';

abstract class EmailRepository {
  Future<Either<Failure, void>> sendEmail(SalkhanaMemberModel member);
  Future<Either<Failure, void>> sendEmails(List<SalkhanaMemberModel> members);
}

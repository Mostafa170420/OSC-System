import '../../data/model/member.dart';

class SalkhanaStates {}

class SalkhanaLoading extends SalkhanaStates {}

class SalkhanaSuccsses extends SalkhanaStates {
  List<SalkhanaMemberModel> members;
  SalkhanaSuccsses({required this.members});
}

class SalkhanaUploadSuccsses extends SalkhanaStates {}

class SalkhanaDownloadSuccsses extends SalkhanaStates {}

class SalkhanaFailureFirestore extends SalkhanaStates {}

class SalkhanaSuccssesFirestore extends SalkhanaStates {}

class SalkhanaSuccssesSendEmail extends SalkhanaStates {}

class SalkhanaFailureNetwork extends SalkhanaStates {}

import 'package:osc_system/features/salkhana/data/model/member.dart';

class SalkhanaStates {}

class SalkhanaLoading extends SalkhanaStates {}

class SalkhanaSucsses extends SalkhanaStates {
  List<SalkhanaMemberModel> members;
  SalkhanaSucsses({required this.members});
}

class SalkhanaFailureFirestore extends SalkhanaStates {}

class SalkhanaSucssesFirestore extends SalkhanaStates {}

class SalkhanaFailureNetwork extends SalkhanaStates {}

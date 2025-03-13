



import '../../data/model/member.dart';


class SalkhanaStates {}

class SalkhanaLoading extends SalkhanaStates {}

class SalkhanaSuccsses extends SalkhanaStates {
  List<SalkhanaMemberModel> members;
  SalkhanaSuccsses({required this.members});
}

class SalkhanaFailureFirestore extends SalkhanaStates {}

class SalkhanaSuccssesFirestore extends SalkhanaStates {}

class SalkhanaFailureNetwork extends SalkhanaStates {}

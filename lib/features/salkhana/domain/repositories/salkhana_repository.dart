import '/../features/salkhana/data/model/member.dart';

abstract class SalkhanaRepository {
  // get all members
  Stream<List<SalkhanaMemberModel>> watchMembers(String salkhanaSeason);
  // add new member
  Future <void> addMember(SalkhanaMemberModel memberModel);
  Future <void> updateMember(SalkhanaMemberModel memberModel);
  Future <void> removeMember(String memberId);
}

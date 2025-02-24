import '/../features/salkhana/data/model/member.dart';
import '/../features/salkhana/domain/repositories/salkhana_repository.dart';

class SalkhanaRepositoryImp extends SalkhanaRepository {
  @override
  Future<void> addMember(SalkhanaMemberModel memberModel) {
    // TODO: implement addMember
    throw UnimplementedError();
  }

  @override
  Future<void> removeMember(String memberId) {
    // TODO: implement removeMember
    throw UnimplementedError();
  }

  @override
  Future<void> updateMember(SalkhanaMemberModel memberModel) {
    // TODO: implement updateMember
    throw UnimplementedError();
  }

  @override
  Stream<List<SalkhanaMemberModel>> watchMembers(String salkhanaSeason) {
    // TODO: implement watchMembers
    throw UnimplementedError();
  }

}
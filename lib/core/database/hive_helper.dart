import 'package:hive/hive.dart';

import '../../features/salkhana/data/model/member.dart';

class HiveHelper {
  static final box = Hive.box<SalkhanaMemberModel>("salkhana_members");
  static List<SalkhanaMemberModel> getMembers() {
    try {
      return box.values.toList();
    } catch (e) {
      rethrow;
    }
  }

  static void removeMember(String id) {
    try {
      box.delete(id);
    } catch (e) {
      rethrow;
    }
  }

  static Stream<BoxEvent> watchMembers() {
    return box.watch();
  }

  static addAllMembers(List<SalkhanaMemberModel> members) {
    for (var member in members) {
      addMember(member);
    }
  }

  static void removeAll() {
    try {
      for (var element in box.keys) {
        box.delete(element);
      }
    } catch (e) {
      rethrow;
    }
  }

  static void addMember(SalkhanaMemberModel member) {
    box.put(member.id, member);
  }
}

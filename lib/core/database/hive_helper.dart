import 'package:hive/hive.dart';

import '../../features/salkhana/data/model/member.dart';

class HiveHelper {
  static final box = Hive.box<SalkhanaMemberModel>("salkhana_members");
  static final authBox = Hive.box("authAdmin");

  static Future<void> registerAdmin(String username, String password) async {
    if (authBox.containsKey(username)) {
      throw Exception("Admin already exists");
    }
    await authBox.put(username, {
      'username': username,
      'password': password,
    });
  }

  static bool loginAdmin(String username, String password) {
    final data = authBox.get(username);
    if (data == null) return false;
    return data['password'] == password;
  }

  static bool adminExists(String username) => authBox.containsKey(username);

  
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

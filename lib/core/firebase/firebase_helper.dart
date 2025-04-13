import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  static final supabase = Supabase.instance.client;
  static Stream<List<Map<String, dynamic>>> getAllDocStream(String path) {
    try {
      return supabase.from("salkhana").stream(primaryKey: ["id"]).execute();
    } catch (e) {
      print("___________Error_____________");
      rethrow;
    }
  }

  static Future<void> removeAllDocs() async {
    try {
      await supabase.from("salkhana").delete().neq('id', '');
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> addAllDocs(List<Map<String, dynamic>> members) async {
    try {
      for (var member in members) {
        await addDoc("path", "id", member);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> getDocs() async {
    try {
      var response = await supabase.from("salkhana").select();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> addDoc(
      String path, String id, Map<String, dynamic> data) async {
    try {
      await supabase.from("salkhana").upsert(data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updateDoc(
      String path, String id, Map<String, dynamic> data) async {
    try {
      await supabase.from("salkhana").upsert(data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> removeDoc(String path, String id) async {
    try {
      await supabase.from("salkhana").delete().eq("id", id);
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
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

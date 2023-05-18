import 'package:programming_hacks/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationRepository {
  Future<bool> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final response = await client.auth
          .signUp(email: email, password: password, data: {'name': name});
      if (response.user == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    client.auth.signOut();
  }
}

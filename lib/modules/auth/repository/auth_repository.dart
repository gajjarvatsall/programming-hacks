import 'package:appwrite/appwrite.dart';

class AuthenticationRepository {
  Future<bool> signUpWithEmailAndPassword(String email, String password, String name) async {
    Client client = Client();
    Account account = Account(client);
    client.setEndpoint('https://cloud.appwrite.io/v1').setProject('646b25f423d8d38d3471').setSelfSigned(status: true);
    try {
      final response = account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      if (response == null) {
        print("false ---- ${response}");
        return false;
      } else {
        print("True ---- ${response}");
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      Client client = Client();
      Account account = Account(client);
      client.setEndpoint('https://cloud.appwrite.io/v1').setProject('646b25f423d8d38d3471').setSelfSigned(status: true);
      await account.createEmailSession(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> oAuth2Session(String provider) {
    Client client = Client();
    Account account = Account(client);
    client.setEndpoint('https://cloud.appwrite.io/v1').setProject('646b25f423d8d38d3471').setSelfSigned(status: true);
    return account.createOAuth2Session(provider: provider);
  }

  Future<void> logout() {
    Client client = Client();
    Account account = Account(client);
    client.setEndpoint('https://cloud.appwrite.io/v1').setProject('646b25f423d8d38d3471').setSelfSigned(status: true);
    return account.deleteSession(sessionId: 'current');
  }
}

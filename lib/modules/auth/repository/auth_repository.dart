import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AuthenticationRepository {
  Future<User> signUpWithEmailAndPassword(String email, String password, String name) async {
    Client client = Client();
    Account account = Account(client);
    Databases databases = Databases(client);

    client.setEndpoint('https://cloud.appwrite.io/v1').setProject('646b25f423d8d38d3471').setSelfSigned(status: true);
    try {
      String userId = ID.unique();
      User currentUser = await account.create(
        userId: userId,
        email: email,
        password: password,
        name: name,
      );

      await databases.createDocument(
        databaseId: "646f0164d40a9ea03541",
        collectionId: "647621e02588ea524453",
        documentId: userId,
        data: {'user_name': currentUser.name, 'user_email': currentUser.email, 'user_id': currentUser.$id},
      );
      return currentUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<Session> login(String email, String password) async {
    try {
      Client client = Client();
      Account account = Account(client);
      client.setEndpoint('https://cloud.appwrite.io/v1').setProject('646b25f423d8d38d3471').setSelfSigned(status: true);
      final response = await account.createEmailSession(
        email: email,
        password: password,
      );
      return response;
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

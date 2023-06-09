import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:programming_hacks/repository/appwrite_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  Client client = AppWriteConfig.getClient();
  Databases databases = AppWriteConfig.getDatabases();

  Future<User> signUpWithEmailAndPassword(String name, String email, String password) async {
    Account account = Account(client);
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
      Account account = Account(client);
      final response = await account.createEmailSession(
        email: email,
        password: password,
      );
      var currentUser = await account.get();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("currentUser", currentUser.name);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> oAuth2Session(String provider) async {
    List<String> userIdList = [];
    Account account = Account(client);
    await account.createOAuth2Session(provider: provider);
    var currentUser = await account.get();
    DocumentList doc =
        await databases.listDocuments(databaseId: "646f0164d40a9ea03541", collectionId: "647621e02588ea524453");
    doc.documents.forEach((element) {
      userIdList.add(element.data['user_id']);
    });

    if (userIdList.contains("${currentUser.$id}")) {
    } else {
      await databases.createDocument(
        databaseId: "646f0164d40a9ea03541",
        collectionId: "647621e02588ea524453",
        documentId: ID.unique(),
        data: {'user_name': currentUser.name, 'user_email': currentUser.email, 'user_id': currentUser.$id},
      );
    }
    return currentUser;
  }

  Future<void> logout() async {
    Account account = Account(client);
    return account.deleteSession(sessionId: 'current');
  }
}

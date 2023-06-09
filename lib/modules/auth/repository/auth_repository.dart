import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  Future<User> signUpWithEmailAndPassword(String name, String email, String password) async {
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
      client.setEndpoint('https://cloud.appwrite.io/v1').setProject('646b25f423d8d38d3471').setSelfSigned(status: true);
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
    Client client = Client();
    List<String> userIdList = [];
    Account account = Account(client);
    Databases databases = Databases(client);
    client.setEndpoint('https://cloud.appwrite.io/v1').setProject('646b25f423d8d38d3471').setSelfSigned(status: true);
    dynamic userAccount = await account.createOAuth2Session(provider: provider);
    var currentUser = await account.get();
    DocumentList doc =
        await databases.listDocuments(databaseId: "646f0164d40a9ea03541", collectionId: "647621e02588ea524453");
    doc.documents.forEach((element) {
      userIdList.add(element.data['user_id']);
    });

    if (userIdList.contains("${currentUser.$id}")) {
      // print(currentUser.$id);
      // print("${currentUser.email} already exists");
    } else {
      await databases.createDocument(
        databaseId: "646f0164d40a9ea03541",
        collectionId: "647621e02588ea524453",
        documentId: ID.unique(),
        data: {'user_name': currentUser.name, 'user_email': currentUser.email, 'user_id': currentUser.$id},
      );
    }

    // print("${response}");

    return currentUser;
  }

  Future<void> logout() async {
    Client client = Client();
    Account account = Account(client);
    client.setEndpoint('https://cloud.appwrite.io/v1').setProject('646b25f423d8d38d3471').setSelfSigned(status: true);
    return account.deleteSession(sessionId: 'current');
  }
}

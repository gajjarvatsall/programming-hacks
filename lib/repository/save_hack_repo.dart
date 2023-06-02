import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class SaveHacksRepository {
  Future<void> saveHack(String hackId) async {
    Client client = Client();
    Databases databases = Databases(client);
    Account account = Account(client);
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('646b25f423d8d38d3471')
        .setSelfSigned(status: true);
    User user = await account.get();
    try {
      await databases.createDocument(
        collectionId: '647862f5b6979f264cda',
        databaseId: '646f0164d40a9ea03541',
        documentId: ID.unique(),
        data: {'hack_id': hackId, 'user_id': user.$id},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Set<String>> fetchSavedHacks() async {
    try {
      Client client = Client();
      Databases databases = Databases(client);
      Account account = Account(client);
      client
          .setEndpoint('https://cloud.appwrite.io/v1')
          .setProject('646b25f423d8d38d3471')
          .setSelfSigned(status: true);
      User user = await account.get();

      final response = await databases.listDocuments(
        collectionId: '647862f5b6979f264cda',
        databaseId: '646f0164d40a9ea03541',
        queries: [
          Query.equal('user_id', user.$id),
        ],
      );

      Set<String> savedHackIds = response.documents.map<String>((e) {
        return e.data['hack_id'];
      }).toSet();

      print("SavedData  :  {${savedHackIds}");

      return savedHackIds;
    } catch (e) {
      print('Error fetching saved hacks: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> unSavedHacks(String documentId) async {
    Client client = Client();
    Databases databases = Databases(client);
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('646b25f423d8d38d3471')
        .setSelfSigned(status: true);
    await databases.deleteDocument(
        databaseId: '646f0164d40a9ea03541',
        collectionId: '647862f5b6979f264cda',
        documentId: documentId);
  }
}

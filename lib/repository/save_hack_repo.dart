import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:programming_hacks/models/saved_hacks_model.dart';

class SaveHacksRepository {
  Future<void> saveHack(String hackId, String techId) async {
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
        data: {'hack_id': hackId, 'user_id': user.$id, 'tech_id': techId},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<SavedHacksModel>> fetchSavedHacks() async {
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

      List<SavedHacksModel> savedHack = response.documents.map((e) {
        return SavedHacksModel.fromJson(e.data);
      }).toList();

      return savedHack;
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

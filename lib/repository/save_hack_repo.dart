import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:programming_hacks/models/saved_hacks_model.dart';
import 'package:programming_hacks/repository/appwrite_client.dart';

class SaveHacksRepository {
  Client client = AppWriteConfig.getClient();
  Databases databases = AppWriteConfig.getDatabases();

  Future<void> saveHack(String hackId, String techId, String hack_details) async {
    Account account = Account(client);
    User user = await account.get();
    try {
      await databases.createDocument(
        collectionId: '647862f5b6979f264cda',
        databaseId: '646f0164d40a9ea03541',
        documentId: ID.unique(),
        data: {'hack_id': hackId, 'user_id': user.$id, 'tech_id': techId, 'hack_details': hack_details},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<SavedHacksModel>> fetchSavedHacks() async {
    try {
      Account account = Account(client);
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
    await databases.deleteDocument(
        databaseId: '646f0164d40a9ea03541', collectionId: '647862f5b6979f264cda', documentId: documentId);
  }
}

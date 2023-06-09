import 'package:appwrite/appwrite.dart';
import 'package:programming_hacks/models/hacks_model.dart';

import 'appwrite_client.dart';

class HacksRepository {
  Client client = AppWriteConfig.getClient();
  Databases databases = AppWriteConfig.getDatabases();

  Future<List<HacksModel>> getHacks(String id) async {
    try {
      List<HacksModel>? hackList = [];
      final response = await databases.listDocuments(
        collectionId: '646f01b4bb666a8518c1',
        databaseId: '646f0164d40a9ea03541',
        queries: [
          Query.equal('tech_id', id),
        ],
      );

      hackList = response.documents.map((e) {
        return HacksModel.fromJson(e.data);
      }).toList();

      return hackList;
    } catch (e) {
      print(e);
      throw AppwriteException(e.toString());
    }
  }

  Future<void> addHacks(String techId, String hackDetails) async {
    await databases.createDocument(
      databaseId: '646f0164d40a9ea03541',
      collectionId: '646f01b4bb666a8518c1',
      documentId: ID.unique(),
      data: {
        'hack_details': hackDetails,
        'tech_id': techId,
      },
    );
  }
}

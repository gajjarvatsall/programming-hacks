import 'package:appwrite/appwrite.dart';
import 'package:programming_hacks/models/hacks_model.dart';

class HacksRepository {
  Future<List<HacksModel>> getHacks(String id) async {
    try {
      Client client = Client();
      Databases databases = Databases(client);
      client.setEndpoint('https://cloud.appwrite.io/v1').setProject('646b25f423d8d38d3471').setSelfSigned(status: true);

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

  Future<void> addUserId(String userId, String documentId) async {
    try {
      Client client = Client();
      Databases databases = Databases(client);
      client.setEndpoint('https://cloud.appwrite.io/v1').setProject('646b25f423d8d38d3471').setSelfSigned(status: true);
      await databases.updateDocument(
        databaseId: '646f0164d40a9ea03541',
        collectionId: '646f01b4bb666a8518c1',
        documentId: documentId,
        data: {'userId': userId},
      );
    } catch (e) {}
  }
}

import 'package:appwrite/appwrite.dart';
import 'package:programming_hacks/models/languages_model.dart';
import 'package:programming_hacks/repository/appwrite_client.dart';

class LanguagesRepository {
  Client client = AppWriteConfig.getClient();
  Databases databases = AppWriteConfig.getDatabases();

  Future<List<TechnologyModel>> getLanguages() async {
    List<TechnologyModel>? languageList = [];
    final response = await databases.listDocuments(
      collectionId: '646f01ad1349fbecabe9',
      databaseId: '646f0164d40a9ea03541',
    );

    languageList = response.documents.map((e) {
      return TechnologyModel.fromJson(e.data);
    }).toList();

    return languageList;
  }
}

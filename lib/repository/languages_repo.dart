import 'package:appwrite/appwrite.dart';
import 'package:programming_hacks/models/languages_model.dart';

class LanguagesRepository {
  Future<List<LanguagesModel>> getLanguages() async {
    Client client = Client();
    Databases databases = Databases(client);
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('646b25f423d8d38d3471')
        .setSelfSigned(status: true);

    List<LanguagesModel>? languageList = [];
    final response = await databases.listDocuments(
      collectionId: '646f01ad1349fbecabe9',
      databaseId: '646f0164d40a9ea03541',
    );

    languageList = response.documents.map((e) {
      return LanguagesModel.fromJson(e.data);
    }).toList();

    return languageList;
  }
}

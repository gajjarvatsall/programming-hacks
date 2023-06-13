import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:programming_hacks/models/users_model.dart';
import 'package:programming_hacks/repository/appwrite_client.dart';

class UsersRepository {
  Client client = AppWriteConfig.getClient();
  Databases databases = AppWriteConfig.getDatabases();

  Future<List<UsersModel>> getUsers() async {
    try {
      Account account = Account(client);
      User currentUser = await account.get();

      List<UsersModel>? userList = [];
      final response = await databases.listDocuments(
        collectionId: '647621e02588ea524453',
        databaseId: '646f0164d40a9ea03541',
        queries: [
          Query.equal('user_email', currentUser.email),
        ],
      );

      userList = response.documents.map((e) {
        print(e.data);
        return UsersModel.fromJson(e.data);
      }).toList();

      return userList;
    } catch (e) {
      print(e);
      throw AppwriteException(e.toString());
    }
  }
}

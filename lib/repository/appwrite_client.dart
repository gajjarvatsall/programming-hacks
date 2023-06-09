import 'package:appwrite/appwrite.dart';

class AppWriteConfig {
  static Client getClient() {
    Client client = Client();
    client.setEndpoint('https://cloud.appwrite.io/v1').setProject('646b25f423d8d38d3471').setSelfSigned(status: true);
    return client;
  }

  static Databases getDatabases() {
    return Databases(getClient());
  }
}

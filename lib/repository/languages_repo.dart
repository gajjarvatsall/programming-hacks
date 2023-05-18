import 'package:programming_hacks/models/languages_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LanguagesRepository {
  Future<List<LanguagesModel>> getLanguages() async {
    final SupabaseClient client = Supabase.instance.client;
    final response = await client.from('Technology').select();
    if (response != null) {
      final data = response as List<dynamic>;
      print("---------- $data");
      return data.map((item) => LanguagesModel.fromJson(item)).toList();
    } else {
      throw response.error!.message;
    }
  }
}

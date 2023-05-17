import 'dart:developer';

import 'package:programming_hacks/models/hacks_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HacksRepository {
  Future<List<HacksModel>> getHacks() async {
    final SupabaseClient client = Supabase.instance.client;
    final response = await client.from('Hacks').select();
    if (response != null) {
      final data = response as List<dynamic>;
      log("data: ${data.runtimeType}");
      return data.map((item) => HacksModel.fromJson(item)).toList();
    } else {
      throw response.error!.message;
    }
  }
}

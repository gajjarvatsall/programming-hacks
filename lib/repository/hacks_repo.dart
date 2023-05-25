// import 'package:programming_hacks/models/hacks_model.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// class HacksRepository {
//   Future<List<HacksModel>> getHacks(int id) async {
//     // final SupabaseClient client = Supabase.instance.client;
//     final response = await client.from('Hacks').select().eq('tech_id', id);
//     if (response != null) {
//       final data = response as List<dynamic>;
//       return data.map((item) => HacksModel.fromJson(item)).toList();
//     } else {
//       throw response.error!.message;
//     }
//   }
// }

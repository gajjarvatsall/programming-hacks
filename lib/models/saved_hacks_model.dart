import 'dart:convert';

SavedHacksModel hacksModelFromJson(String str) => SavedHacksModel.fromJson(json.decode(str));

String hacksModelToJson(SavedHacksModel data) => json.encode(data.toJson());

class SavedHacksModel {
  String id;
  String hackId;

  SavedHacksModel({
    required this.id,
    required this.hackId,
  });

  factory SavedHacksModel.fromJson(Map<String, dynamic> json) => SavedHacksModel(
        id: json["\$id"],
        hackId: json["hack_id"],
      );

  Map<String, dynamic> toJson() => {
        "\$id": id,
        "hack_id": hackId,
      };
}

class LanguagesModel {
  String? id;
  String? createdAt;
  String? name;
  String? bgImage;

  LanguagesModel({this.id, this.createdAt, this.name, this.bgImage});

  LanguagesModel.fromJson(Map<String, dynamic> json) {
    id = json['\$id'];
    createdAt = json['\$created_at'];
    name = json['tech_name'];
    bgImage = json['bg_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$id'] = id;
    data['\$created_at'] = createdAt;
    data['tech_name'] = name;
    data['bg_image'] = bgImage;
    return data;
  }
}

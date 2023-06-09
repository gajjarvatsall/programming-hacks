class LanguagesModel {
  int? id;
  String? createdAt;
  String? name;
  String? bgImage;

  LanguagesModel({this.id, this.createdAt, this.name, this.bgImage});

  LanguagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    name = json['name'];
    bgImage = json['bg_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['name'] = name;
    data['bg_image'] = bgImage;
    return data;
  }
}

class LanguagesModel {
  int? id;
  String? createdAt;
  String? name;

  LanguagesModel({this.id, this.createdAt, this.name});

  LanguagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['name'] = name;
    return data;
  }
}

class HacksModel {
  String? id;
  String? hackDetails;
  String? techId;
  List<dynamic>? userId;

  HacksModel({this.id, this.hackDetails, this.techId, this.userId});

  HacksModel.fromJson(Map<String, dynamic> json) {
    id = json['\$id'];
    hackDetails = json['hack_details'];
    techId = json['tech_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$id'] = id;
    data['hack_details'] = hackDetails;
    data['tech_id'] = techId;
    data['user_id'] = userId;
    return data;
  }
}

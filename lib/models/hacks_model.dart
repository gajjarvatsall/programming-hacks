class HacksModel {
  int? id;
  String? hackDetails;
  int? techId;

  HacksModel({this.id, this.hackDetails, this.techId});

  HacksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hackDetails = json['hack_details'];
    techId = json['tech_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hack_details'] = hackDetails;
    data['tech_id'] = techId;
    return data;
  }
}

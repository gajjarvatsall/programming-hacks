class UsersModel {
  String? name;
  String? email;
  String? userId;

  UsersModel({this.name, this.email, this.userId});

  UsersModel.fromJson(Map<String, dynamic> json) {
    name = json['tech_name'];
    email = json['user_email'];
    userId = json['\$user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = name;
    data['user_email'] = email;
    data['\$user_id'] = userId;
    return data;
  }
}

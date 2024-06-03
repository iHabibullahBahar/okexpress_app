class ProfileModel {
  int? id;
  String? name;
  String? photo;
  String? email;
  double? lat;
  double? lng;
  String? lastLogin;

  ProfileModel(
      {this.id,
      this.name,
      this.photo,
      this.email,
      this.lat,
      this.lng,
      this.lastLogin});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    email = json['email'];
    lat = json['lat']?.toDouble();
    lng = json['lng']?.toDouble();
    lastLogin = json['lastLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['email'] = this.email;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['lastLogin'] = this.lastLogin;
    return data;
  }
}

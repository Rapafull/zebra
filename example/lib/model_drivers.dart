class ModelDrivers {
  ModelDrivers({
      this.name, 
      this.address,});

  ModelDrivers.fromJson(dynamic json) {
    name = json['name'];
    address = json['address'];
  }
  String? name;
  String? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['address'] = address;
    return map;
  }

}
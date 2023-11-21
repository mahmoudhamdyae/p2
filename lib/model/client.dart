class Client {
  int id;
  String name;
  String phone;
  String address;
  String vegetableName;
  String fridgeName;

  Client(
      this.id, this.name, this.phone, this.address, this.vegetableName, this.fridgeName
      );

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      json['id'] as int? ?? -1,
      json['name'] as String? ?? "",
      json['phone'] as String? ?? "",
      json['address'] as String? ?? "",
      json['vegetable_name'] as String? ?? "",
      json['fridge_name'] as String? ?? ""
    );
  }
}
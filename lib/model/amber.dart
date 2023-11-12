import 'fridge.dart';

class Amber {
  int id;
  String name;
  String size;
  int user_id;
  Owner owner;

  Amber(this.id, this.name, this.size, this.user_id, this.owner);

  factory Amber.fromJson(Map<String, dynamic> json) {
    Owner owner = json["owner"] as Owner? ?? Owner("");
    return Amber(
      json['id'] as int,
      json['name'] as String? ?? "",
      json['size'] as String? ?? "0",
      json['user_id'] as int? ?? -1,
      Owner(owner.name),
    );
  }
}
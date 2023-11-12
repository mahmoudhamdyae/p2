import 'package:testt/model/amber.dart';

class Fridge {
  int id;
  String name;
  String size;
  int userId;
  Owner owner;
  List<Amber> ambers = [];

  Fridge(this.id, this.name, this.size, this.userId, this.owner, this.ambers);

  factory Fridge.fromJson(Map<String, dynamic> json) {
    List<Amber> ambers = [];
    for (var singleAmber in json["ambers"]) {
      ambers.add(Amber.fromJson(singleAmber));
    }
    return Fridge(
      json['id'] as int,
      json['name'] as String,
      json['size'] as String,
      json['user_id'] as int,
      Owner(json['owner']["name"]),
      ambers
    );
  }
}

class Owner {
  String name;

  Owner(this.name);
}
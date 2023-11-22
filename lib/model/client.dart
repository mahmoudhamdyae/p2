import 'package:testt/model/term.dart';

import 'amber.dart';
import 'fridge.dart';

class Client {
  int id;
  String name;
  String phone;
  String address;
  String vegetableName;
  String fridgeName;
  // Amber amber;
  // Fridge fridge;
  // Term term

  Client(
      this.id, this.name, this.phone, this.address, this.vegetableName, this.fridgeName//, this.amber, this.fridge, //this.term
      );

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      json['id'] as int? ?? -1,
      json['name'] as String? ?? "",
      json['phone'] as String? ?? "",
      json['address'] as String? ?? "",
      json['vegetable_name'] as String? ?? "",
      json['fridge_name'] as String? ?? "",
      // Amber.fromJson(json["amber_details"]),
      // Fridge.fromJson(json["amber_details"]["fridge"]),
      // Term.fromJson(json[])
    );
  }
}
import 'package:uuid/uuid.dart';

class Masrofat {
  int id;
  String amount;
  String description;
  String date;

  Masrofat(this.id, this.amount, this.description, this.date);

  factory Masrofat.fromJson(Map<String, dynamic> json) {
    return Masrofat(
        json['id'] as int? ?? int.parse(const Uuid().v4()),
        json['amount'] as String? ?? "",
        json['description'] as String? ?? "",
        json['date'] as String? ?? "",
    );
  }
}
import 'package:uuid/uuid.dart';

class Price {
  String vegetableName;
  String ton;
  String small_shakara;
  String big_shakara;
  int user_id;
  int id;

  Price(this.vegetableName, this.ton, this.small_shakara, this.big_shakara, this.user_id, this.id);

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
        json['vegetableName'] as String? ?? "",
        json['ton'] as String? ?? "-1",
        json['small_shakara'] as String? ?? "-1",
        json['big_shakara'] as String? ?? "-1",
        json['user_id'] as int? ?? -1,
        json['id'] as int? ?? -1,
    );
  }
}
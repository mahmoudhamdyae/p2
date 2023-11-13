import 'package:uuid/uuid.dart';

class Price {
  String vegetableName;
  int ton;
  int small_shakara;
  int big_shakara;
  int user_id;
  int id;

  Price(this.vegetableName, this.ton, this.small_shakara, this.big_shakara, this.user_id, this.id);

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
        json['vegetableName'] as String,
        json['ton'] as int,
        json['small_shakara'] as int,
        json['big_shakara'] as int,
        json['user_id'] as int,
        json['id'] as int,
    );
  }
}
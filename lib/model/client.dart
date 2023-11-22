class Client {
  int id;
  String name;
  String phone;
  String address;
  String vegetableName;
  String fridgeName;
  String amberName;
  String termName;
  int fridgeId;
  int amberId;
  int termId;
  int priceId;

  Client(
      this.id, this.name, this.phone, this.address, this.vegetableName, this.fridgeName, this.amberName, this.termName, this.fridgeId, this.amberId, this.termId, this.priceId
      );

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      json['id'] as int? ?? -1,
      json['name'] as String? ?? "",
      json['phone'] as String? ?? "",
      json['address'] as String? ?? "",
      json['vegetable_name'] as String? ?? "",
      json['fridge'] as String? ?? "",
      json['amber'] as String? ?? "",
      json['term'] as String? ?? "",
      json['fridge_id'] as int? ?? 0,
      json['amber_id'] as int? ?? 0,
      json['term_id'] as int? ?? 0,
      json['price_list_id'] as int? ?? 0,
    );
  }
}
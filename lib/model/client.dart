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
  String status;
  String pricaAll;

  Client(
      this.id, this.name, this.phone, this.address, this.vegetableName, this.fridgeName, this.amberName, this.termName, this.fridgeId, this.amberId, this.termId, this.priceId, this.status, this.pricaAll
      );

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      json['id'] as int? ?? -1,
      json['name'] as String? ?? "",
      json['phone'] as String? ?? "",
      json['address'] as String? ?? "",
      json['vegetable_name'] as String? ?? "",
      json["data"]['fridge'] as String? ?? "",
      json["data"]['amber'] as String? ?? "",
      json["term_details"]['name'] as String? ?? "",
      json["data"]['fridge_id'] as int? ?? 0,
      json["data"]['amber_id'] as int? ?? 0,
      json["data"]['term_id'] as int? ?? 0,
      json["data"]['price_list_id'] as int? ?? 0,
      json["data"]["status"] as String? ?? "person",
      json["data"]["price_all"] as String? ?? "0",
    );
  }
}
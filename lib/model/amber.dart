class Amber {
  int id;
  String name;
  String size;
  int user_id;

  Amber(this.id, this.name, this.size, this.user_id);

  factory Amber.fromJson(Map<String, dynamic> json) {
    return Amber(
        json['id'] as int,
        json['name'] as String? ?? "",
      // "",
        json['size'] as String? ?? "0",
      // "",
        json['user_id'] as int? ?? -1
      // 3
    );
  }
}
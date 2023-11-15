class AllUsers {
  String id;
  String name;
  String phone;
  int active;

  AllUsers(this.id, this.name, this.phone, this.active);

  factory AllUsers.fromJson(Map<String, dynamic> json) {
    return AllUsers(
      json["id"] as String? ?? "",
      json['name'] as String? ?? "",
      json['phone'] as String? ?? "0",
      json['active'] as int? ?? 0
    );
  }
}
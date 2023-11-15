class PersonalData {
  String name;
  String phone;
  int active;

  PersonalData(this.name, this.phone, this.active);

  factory PersonalData.fromJson(Map<String, dynamic> json) {
    return PersonalData(
        json["user"]['name'] as String? ?? "",
        json["user"]['phone'] as String? ?? "",
        json["user"]['active'] as int? ?? 0
    );
  }
}
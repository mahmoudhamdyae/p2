class Fridge {
  int id;
  String name;
  String size;
  int user_id;
  Owner owner;

  Fridge(this.id, this.name, this.size, this.user_id, this.owner);

  factory Fridge.fromJson(Map<String, dynamic> json) {
    return Fridge(
      json['id'] as int,
      json['name'] as String,
      json['size'] as String,
      json['user_id'] as int,
      Owner(json['owner']["name"])
    );
  }
}

class Owner {
  String name;

  Owner(this.name);
}
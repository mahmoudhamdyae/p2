class Term {
  int id;
  String name;
  String start;
  String end;
  int user_id;

  Term(this.id, this.name, this.start, this.end, this.user_id);

  factory Term.fromJson(Map<String, dynamic> json) {
    return Term(
        json['id'] as int? ?? 0,
        json['name'] as String? ?? "",
        json['start'] as String? ?? "",
        json['end'] as String? ?? "",
        json['user_id'] as int? ?? 0,
    );
  }
}
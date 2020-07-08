class BabyEntity {
  final String id;
  final String name;
  final String gender;
  final DateTime birthDate;

  BabyEntity({this.id, this.name, this.gender, this.birthDate});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BabyEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          gender == other.gender &&
          birthDate == other.birthDate;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ gender.hashCode ^ birthDate.hashCode;

  @override
  String toString() {
    return 'BabyEntity{id: $id, name: $name, gender: $gender, birthDate: $birthDate}';
  }

  Map<String, Object> toJson() {
    return {
      'birthdate': birthDate.toIso8601String(),
      'gender': gender,
      'name': name,
      'id': id,
    };
  }

  static BabyEntity fromJson(Map<String, Object> json) {
    return BabyEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      birthDate: DateTime.parse(json['birthdate'] as String),
    );
  }
}

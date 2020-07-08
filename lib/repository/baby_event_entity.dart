class BabyEventEntity {
  final String id;
  final String description;
  final String type;
  final DateTime start;
  final DateTime end;
  final String notes;

  BabyEventEntity(
      {this.id, this.description, this.type, this.start, this.end, this.notes});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BabyEventEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          description == other.description &&
          type == other.type &&
          start == other.start &&
          end == other.end &&
          notes == other.notes;

  @override
  int get hashCode =>
      id.hashCode ^
      description.hashCode ^
      type.hashCode ^
      start.hashCode ^
      end.hashCode ^
      notes.hashCode;

  @override
  String toString() {
    return 'BabyEventEntity{id: $id, description: $description, type: $type, start: $start, end: $end, notes: $notes}';
  }

  Map<String, Object> toJson() {
    return {
      'end': end.toIso8601String(),
      'start': start.toIso8601String(),
      'notes': notes,
      'description': description,
      'type': type,
      'id': id,
    };
  }

  static BabyEventEntity fromJson(Map<String, Object> json) {
    return BabyEventEntity(
      id: json['id'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      notes: json['notes'] as String,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
    );
  }
}

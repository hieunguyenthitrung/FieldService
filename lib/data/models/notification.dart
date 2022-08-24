import 'dart:convert';
import 'dart:math';

class Notification {
  int id;
  int parentId;
  String title;
  String description;
  String createOn;
  bool isRead;
  Notification({
    required this.id,
    required this.parentId,
    required this.title,
    required this.description,
    required this.createOn,
    required this.isRead,
  });

  Notification copyWith({
    int? id,
    int? parentId,
    String? title,
    String? description,
    String? createOn,
    bool? isRead,
  }) {
    return Notification(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      title: title ?? this.title,
      description: description ?? this.description,
      createOn: createOn ?? this.createOn,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'parentId': parentId,
      'title': title,
      'description': description,
      'createOn': createOn,
      'isRead': isRead,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id']?.toInt() ?? 0,
      parentId: map['parentId']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createOn: map['createOn'] ?? '',
      isRead: map['isRead'] ?? false,
    );
  }

  factory Notification.genTestData() {
    return Notification(
        id: Random().nextInt(50),
        parentId: Random().nextInt(100),
        title: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        createOn: DateTime.now().subtract(Duration(minutes: Random().nextInt(120))).toIso8601String(),
        isRead: Random().nextBool(),
        );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) =>
      Notification.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notification(id: $id, parentId: $parentId, title: $title, description: $description, createOn: $createOn, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Notification &&
        other.id == id &&
        other.parentId == parentId &&
        other.title == title &&
        other.description == description &&
        other.createOn == createOn &&
        other.isRead == isRead;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        parentId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        createOn.hashCode ^
        isRead.hashCode;
  }
}

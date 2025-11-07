enum SavedItemType {
  search,
  topic,
}

class SavedItem {
  final String id;
  final String title;
  final SavedItemType type;
  final String? query;
  final String? topicId;
  final DateTime createdAt;

  SavedItem({
    required this.id,
    required this.title,
    required this.type,
    this.query,
    this.topicId,
    required this.createdAt,
  });

  factory SavedItem.fromJson(Map<String, dynamic> json) {
    return SavedItem(
      id: json['id'] as String,
      title: json['title'] as String,
      type: SavedItemType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => SavedItemType.topic,
      ),
      query: json['query'] as String?,
      topicId: json['topicId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type.name,
      'query': query,
      'topicId': topicId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

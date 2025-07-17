class TipModel {
  final int? id;
  final String title;
  final String content;
  final String? image;
  final String createdAt;

  TipModel({
    this.id,
    required this.title,
    required this.content,
    this.image,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'created_at': createdAt,
    };
  }

  factory TipModel.fromMap(Map<String, dynamic> map) {
    return TipModel(
      id: map['id']?.toInt(),
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      image: map['image'],
      createdAt: map['created_at'] ?? '',
    );
  }

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      id: json['id']?.toInt(),
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      image: json['image'],
      createdAt: json['created_at'] ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'created_at': createdAt,
    };
  }
}

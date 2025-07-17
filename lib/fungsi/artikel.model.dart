class ArtikelModel {
  final int? id;
  final String title;
  final String content;
  final String category;
  final String? imageUrl;
  final String? videoUrl;
  final String publishDate;
  final String createdAt;

  ArtikelModel({
    this.id,
    required this.title,
    required this.content,
    required this.category,
    this.imageUrl,
    this.videoUrl,
    required this.publishDate,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'image_url': imageUrl,
      'video_url': videoUrl,
      'publish_date': publishDate,
      'created_at': createdAt,
    };
  }

  factory ArtikelModel.fromMap(Map<String, dynamic> map) {
    return ArtikelModel(
      id: map['id']?.toInt(),
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      category: map['category'] ?? '',
      imageUrl: map['image_url'],
      videoUrl: map['video_url'],
      publishDate: map['publish_date'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  factory ArtikelModel.fromJson(Map<String, dynamic> json) {
    return ArtikelModel(
      id: json['id']?.toInt(),
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['image_url'],
      videoUrl: json['video_url'],
      publishDate: json['publish_date'] ?? '',
      createdAt: json['created_at'] ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'image_url': imageUrl,
      'video_url': videoUrl,
      'publish_date': publishDate,
      'created_at': createdAt,
    };
  }
}

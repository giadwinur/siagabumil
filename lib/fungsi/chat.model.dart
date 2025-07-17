class ChatModel {
  final int? id;
  final String message;
  final bool isUser;
  final String timestamp;

  ChatModel({
    this.id,
    required this.message,
    required this.isUser,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'is_user': isUser ? 1 : 0,
      'timestamp': timestamp,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id']?.toInt(),
      message: map['message'] ?? '',
      isUser: map['is_user'] == 1,
      timestamp: map['timestamp'] ?? '',
    );
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id']?.toInt(),
      message: json['message'] ?? '',
      isUser: json['is_user'] ?? false,
      timestamp: json['timestamp'] ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'is_user': isUser,
      'timestamp': timestamp,
    };
  }
}

enum MessageType {
  user,
  assistant,
  system,
}

class MessageModel {
  final String id;
  final String chatId;
  final String content;
  final MessageType type;
  final DateTime timestamp;
  final bool isLoading;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.content,
    required this.type,
    required this.timestamp,
    this.isLoading = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      chatId: json['chat_id'] ?? '',
      content: json['content'] ?? '',
      type: MessageType.values.firstWhere(
        (e) => e.toString() == 'MessageType.${json['type'] ?? 'user'}',
        orElse: () => MessageType.user,
      ),
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      isLoading: json['is_loading'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_id': chatId,
      'content': content,
      'type': type.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
      'is_loading': isLoading,
    };
  }

  MessageModel copyWith({
    String? id,
    String? chatId,
    String? content,
    MessageType? type,
    DateTime? timestamp,
    bool? isLoading,
  }) {
    return MessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      content: content ?? this.content,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isLoading: isLoading ?? this.isLoading,
    );
  }
} 
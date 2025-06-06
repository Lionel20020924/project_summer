import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../data/models/chat_model.dart';
import '../data/models/message_model.dart';

class ChatService extends GetxService {
  static ChatService get to => Get.find();
  
  final RxList<ChatModel> _chats = <ChatModel>[].obs;
  List<ChatModel> get chats => _chats;
  
  final RxMap<String, List<MessageModel>> _messages = <String, List<MessageModel>>{}.obs;
  RxMap<String, List<MessageModel>> get messages => _messages;
  
  final _uuid = const Uuid();

  @override
  void onInit() {
    super.onInit();
    _loadDemoData();
  }

  void _loadDemoData() {
    // Create some demo chats
    final demoChats = [
      ChatModel(
        id: '1',
        title: 'AI助手对话',
        lastMessage: '你好！有什么可以帮助你的吗？',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        unreadCount: 1,
      ),
      ChatModel(
        id: '2',
        title: '学习助手',
        lastMessage: '今天想学习什么新知识呢？',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        unreadCount: 0,
      ),
      ChatModel(
        id: '3',
        title: '代码助手',
        lastMessage: '需要帮助解决编程问题吗？',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
        unreadCount: 2,
      ),
    ];
    
    _chats.addAll(demoChats);
    
    // Create demo messages for first chat
    _messages['1'] = [
      MessageModel(
        id: '1',
        chatId: '1',
        content: '你好！',
        type: MessageType.user,
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      MessageModel(
        id: '2',
        chatId: '1',
        content: '你好！有什么可以帮助你的吗？',
        type: MessageType.assistant,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ];
  }

  ChatModel? getChatById(String chatId) {
    try {
      return _chats.firstWhere((chat) => chat.id == chatId);
    } catch (e) {
      return null;
    }
  }

  List<MessageModel> getMessagesByChatId(String chatId) {
    return _messages[chatId] ?? [];
  }

  ChatModel createNewChat({String? title}) {
    final chat = ChatModel(
      id: _uuid.v4(),
      title: title ?? '新对话 ${_chats.length + 1}',
      lastMessage: '',
      lastMessageTime: DateTime.now(),
    );
    
    _chats.insert(0, chat);
    _messages[chat.id] = [];
    
    return chat;
  }

  void deleteChat(String chatId) {
    _chats.removeWhere((chat) => chat.id == chatId);
    _messages.remove(chatId);
  }

  void sendMessage(String chatId, String content) {
    final userMessage = MessageModel(
      id: _uuid.v4(),
      chatId: chatId,
      content: content,
      type: MessageType.user,
      timestamp: DateTime.now(),
    );

    // Add user message
    if (_messages[chatId] == null) {
      _messages[chatId] = [];
    }
    _messages[chatId]!.add(userMessage);

    // Update chat last message
    final chatIndex = _chats.indexWhere((chat) => chat.id == chatId);
    if (chatIndex != -1) {
      _chats[chatIndex] = _chats[chatIndex].copyWith(
        lastMessage: content,
        lastMessageTime: DateTime.now(),
      );
    }

    // Simulate AI response
    _simulateAIResponse(chatId, content);
  }

  void _simulateAIResponse(String chatId, String userMessage) async {
    // Add loading message
    final loadingMessage = MessageModel(
      id: _uuid.v4(),
      chatId: chatId,
      content: '',
      type: MessageType.assistant,
      timestamp: DateTime.now(),
      isLoading: true,
    );
    
    _messages[chatId]!.add(loadingMessage);
    _messages.refresh();

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // Remove loading message and add real response
    _messages[chatId]!.removeWhere((msg) => msg.id == loadingMessage.id);
    
    final aiResponse = _generateAIResponse(userMessage);
    final responseMessage = MessageModel(
      id: _uuid.v4(),
      chatId: chatId,
      content: aiResponse,
      type: MessageType.assistant,
      timestamp: DateTime.now(),
    );
    
    _messages[chatId]!.add(responseMessage);

    // Update chat last message
    final chatIndex = _chats.indexWhere((chat) => chat.id == chatId);
    if (chatIndex != -1) {
      _chats[chatIndex] = _chats[chatIndex].copyWith(
        lastMessage: aiResponse,
        lastMessageTime: DateTime.now(),
      );
    }
  }

  String _generateAIResponse(String userMessage) {
    // Simple response generation for demo
    final responses = [
      '这是一个很好的问题！让我来帮助你解答。',
      '我理解你的意思，这里有一些建议...',
      '根据你的描述，我认为你可以尝试以下方法。',
      '这个话题很有趣！让我们深入探讨一下。',
      '我很乐意帮助你！你还有其他问题吗？',
    ];
    
    return responses[DateTime.now().millisecond % responses.length];
  }

  void markChatAsRead(String chatId) {
    final chatIndex = _chats.indexWhere((chat) => chat.id == chatId);
    if (chatIndex != -1) {
      _chats[chatIndex] = _chats[chatIndex].copyWith(unreadCount: 0);
    }
  }
} 
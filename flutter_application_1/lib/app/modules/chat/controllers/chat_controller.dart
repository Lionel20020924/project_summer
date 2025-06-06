import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/chat_service.dart';
import '../../../data/models/chat_model.dart';
import '../../../data/models/message_model.dart';

class ChatController extends GetxController {
  final ChatService _chatService = ChatService.to;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  final RxString chatId = ''.obs;
  final Rx<ChatModel?> currentChat = Rx<ChatModel?>(null);
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null && arguments['chatId'] != null) {
      chatId.value = arguments['chatId'];
      _loadChat();
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void _loadChat() {
    currentChat.value = _chatService.getChatById(chatId.value);
    messages.value = _chatService.getMessagesByChatId(chatId.value);
    
    // Listen to messages changes
    ever(_chatService.messages, (Map<String, List<MessageModel>> allMessages) {
      final chatMessages = allMessages[chatId.value] ?? [];
      messages.value = List.from(chatMessages);
      _scrollToBottom();
    });
    
    // Scroll to bottom initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void sendMessage() {
    final content = messageController.text.trim();
    if (content.isEmpty) return;

    _chatService.sendMessage(chatId.value, content);
    messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  String formatMessageTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(time.year, time.month, time.day);

    if (messageDate == today) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      return '${time.month}/${time.day} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
  }

  void onBackPressed() {
    Get.back();
  }
} 
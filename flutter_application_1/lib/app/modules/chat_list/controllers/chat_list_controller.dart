import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/auth_service.dart';
import '../../../services/chat_service.dart';
import '../../../routes/app_routes.dart';
import '../../../data/models/chat_model.dart';

class ChatListController extends GetxController {
  final AuthService _authService = AuthService.to;
  final ChatService _chatService = ChatService.to;
  
  List<ChatModel> get chats => _chatService.chats;

  @override
  void onInit() {
    super.onInit();
    // Ensure user is logged in
    if (!_authService.isLoggedIn) {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }

  void openChat(String chatId) {
    _chatService.markChatAsRead(chatId);
    Get.toNamed(AppRoutes.CHAT, arguments: {'chatId': chatId});
  }

  void createNewChat() {
    final chat = _chatService.createNewChat();
    Get.toNamed(AppRoutes.CHAT, arguments: {'chatId': chat.id});
  }

  void deleteChat(String chatId) {
    Get.dialog(
      AlertDialogWidget(
        title: '删除对话',
        content: '确定要删除这个对话吗？删除后无法恢复。',
        onConfirm: () {
          _chatService.deleteChat(chatId);
          Get.back();
        },
      ),
    );
  }

  void logout() {
    Get.dialog(
      AlertDialogWidget(
        title: '退出登录',
        content: '确定要退出登录吗？',
        onConfirm: () async {
          await _authService.logout();
          Get.offAllNamed(AppRoutes.LOGIN);
        },
      ),
    );
  }

  String formatLastMessageTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return '刚刚';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      return '${time.month}/${time.day}';
    }
  }
}

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: onConfirm,
          child: const Text('确定'),
        ),
      ],
    );
  }
} 
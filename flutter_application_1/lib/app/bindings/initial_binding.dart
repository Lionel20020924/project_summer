import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../services/chat_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<ChatService>(ChatService(), permanent: true);
  }
} 
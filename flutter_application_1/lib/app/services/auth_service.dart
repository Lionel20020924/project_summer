import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/user_model.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  
  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);
  UserModel? get currentUser => _currentUser.value;
  
  final RxBool _isLoggedIn = false.obs;
  bool get isLoggedIn => _isLoggedIn.value;

  @override
  void onInit() {
    super.onInit();
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('current_user');
    if (userJson != null) {
      // In a real app, you would parse the JSON here
      // For demo purposes, we'll create a dummy user
      _currentUser.value = UserModel(
        id: '1',
        username: 'Demo User',
        email: 'demo@example.com',
        createdAt: DateTime.now(),
      );
      _isLoggedIn.value = true;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // In a real app, you would make an HTTP request here
      if (email.isNotEmpty && password.isNotEmpty) {
        final user = UserModel(
          id: '1',
          username: email.split('@')[0],
          email: email,
          createdAt: DateTime.now(),
        );
        
        _currentUser.value = user;
        _isLoggedIn.value = true;
        
        // Save to storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('current_user', 'logged_in'); // Simplified storage
        
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser.value = null;
    _isLoggedIn.value = false;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<bool> register(String username, String email, String password) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: username,
        email: email,
        createdAt: DateTime.now(),
      );
      
      _currentUser.value = user;
      _isLoggedIn.value = true;
      
      // Save to storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', 'logged_in');
      
      return true;
    } catch (e) {
      return false;
    }
  }
} 
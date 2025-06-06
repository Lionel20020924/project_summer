import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                
                // Logo or App Title
                _buildHeader(),
                
                const SizedBox(height: 40),
                
                // Form Fields
                Obx(() => _buildFormFields()),
                
                const SizedBox(height: 32),
                
                // Submit Button
                Obx(() => _buildSubmitButton()),
                
                const SizedBox(height: 16),
                
                // Toggle Mode Button
                Obx(() => _buildToggleModeButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.chat_bubble_outline,
            size: 40,
            color: Colors.blue.shade600,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'ChatAI',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Text(
          controller.isLoginMode.value ? '欢迎回来' : '创建新账户',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        )),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        // Username field (only for registration)
        if (!controller.isLoginMode.value) ...[
          TextFormField(
            controller: controller.usernameController,
            validator: controller.validateUsername,
            decoration: InputDecoration(
              labelText: '用户名',
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
          ),
          const SizedBox(height: 16),
        ],
        
        // Email field
        TextFormField(
          controller: controller.emailController,
          validator: controller.validateEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: '邮箱',
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        ),
        const SizedBox(height: 16),
        
        // Password field
        TextFormField(
          controller: controller.passwordController,
          validator: controller.validatePassword,
          obscureText: controller.obscurePassword.value,
          decoration: InputDecoration(
            labelText: '密码',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                controller.obscurePassword.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: controller.togglePasswordVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        ),
        
        // Confirm Password field (only for registration)
        if (!controller.isLoginMode.value) ...[
          const SizedBox(height: 16),
          TextFormField(
            controller: controller.confirmPasswordController,
            validator: controller.validateConfirmPassword,
            obscureText: controller.obscureConfirmPassword.value,
            decoration: InputDecoration(
              labelText: '确认密码',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  controller.obscureConfirmPassword.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: controller.toggleConfirmPasswordVisibility,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: controller.isLoading.value ? null : controller.submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade600,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: controller.isLoading.value
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                controller.isLoginMode.value ? '登录' : '注册',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildToggleModeButton() {
    return TextButton(
      onPressed: controller.isLoading.value ? null : controller.toggleMode,
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
          children: [
            TextSpan(
              text: controller.isLoginMode.value ? '还没有账户？' : '已有账户？',
            ),
            TextSpan(
              text: controller.isLoginMode.value ? '立即注册' : '立即登录',
              style: TextStyle(
                color: Colors.blue.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
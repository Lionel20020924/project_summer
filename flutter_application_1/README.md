# ChatAI - Flutter GetX 聊天应用

这是一个基于 Flutter 和 GetX 框架构建的 ChatAI 应用，包含完整的登录、聊天列表和聊天界面功能。

## 项目结构

```
lib/
├── main.dart                           # 应用入口文件
└── app/
    ├── bindings/                       # 依赖注入绑定
    │   └── initial_binding.dart        # 初始绑定
    ├── data/                          # 数据层
    │   └── models/                    # 数据模型
    │       ├── user_model.dart        # 用户模型
    │       ├── chat_model.dart        # 聊天模型
    │       └── message_model.dart     # 消息模型
    ├── modules/                       # 功能模块
    │   ├── login/                     # 登录模块
    │   │   ├── bindings/
    │   │   │   └── login_binding.dart
    │   │   ├── controllers/
    │   │   │   └── login_controller.dart
    │   │   └── views/
    │   │       └── login_view.dart
    │   ├── chat_list/                 # 聊天列表模块
    │   │   ├── bindings/
    │   │   │   └── chat_list_binding.dart
    │   │   ├── controllers/
    │   │   │   └── chat_list_controller.dart
    │   │   └── views/
    │   │       └── chat_list_view.dart
    │   └── chat/                      # 聊天界面模块
    │       ├── bindings/
    │       │   └── chat_binding.dart
    │       ├── controllers/
    │       │   └── chat_controller.dart
    │       └── views/
    │           └── chat_view.dart
    ├── routes/                        # 路由配置
    │   ├── app_pages.dart             # 页面路由
    │   └── app_routes.dart            # 路由常量
    └── services/                      # 服务层
        ├── auth_service.dart          # 认证服务
        └── chat_service.dart          # 聊天服务
```

## 功能特性

### 🔐 登录模块
- 用户登录和注册
- 表单验证
- 密码可见性切换
- 本地存储用户信息
- 自动登录检查

### 💬 聊天列表
- 显示所有聊天对话
- 用户信息卡片
- 创建新对话
- 删除对话
- 未读消息计数
- 最后消息时间显示
- 退出登录功能

### 🗨️ 聊天界面
- 实时消息发送和接收
- 消息气泡样式
- AI 响应模拟
- 加载状态指示
- 自动滚动到底部
- 时间戳显示

## 技术栈

- **Flutter**: UI 框架
- **GetX**: 状态管理、依赖注入、路由管理
- **SharedPreferences**: 本地数据存储
- **UUID**: 唯一标识符生成
- **HTTP**: 网络请求（预留）

## 安装和运行

1. 确保已安装 Flutter SDK
2. 克隆项目到本地
3. 进入项目目录
4. 安装依赖：
   ```bash
   flutter pub get
   ```
5. 运行应用：
   ```bash
   flutter run
   ```

## GetX 架构说明

### 状态管理
- 使用 `Rx` 变量进行响应式状态管理
- `Obx()` 组件自动监听状态变化
- 控制器继承 `GetxController` 管理页面状态

### 依赖注入
- `InitialBinding` 注册全局服务
- 各模块使用 `Binding` 注册控制器
- `Get.find()` 获取依赖实例

### 路由管理
- 声明式路由配置
- 页面间参数传递
- 路由守卫和中间件支持

### 服务层
- `AuthService`: 处理用户认证逻辑
- `ChatService`: 管理聊天数据和消息

## 使用说明

1. **登录**: 输入任意邮箱和密码（长度≥6）即可登录
2. **注册**: 切换到注册模式，填写用户名、邮箱和密码
3. **聊天列表**: 查看所有对话，点击进入聊天或创建新对话
4. **聊天**: 发送消息，AI 会自动回复（模拟）

## 自定义和扩展

### 添加新页面
1. 在 `lib/app/modules/` 下创建新模块目录
2. 创建 `controllers/`、`views/`、`bindings/` 子目录
3. 在 `app_routes.dart` 添加路由常量
4. 在 `app_pages.dart` 配置路由

### 添加新服务
1. 在 `lib/app/services/` 下创建服务文件
2. 继承 `GetxService` 类
3. 在 `InitialBinding` 中注册服务

### 集成真实 API
1. 修改 `AuthService` 中的登录/注册方法
2. 修改 `ChatService` 中的消息发送逻辑
3. 添加 HTTP 请求处理
4. 处理错误和加载状态

## 注意事项

- 当前版本使用模拟数据，实际使用需要集成真实 API
- 消息存储在内存中，应用重启后会丢失
- 可以根据需要添加数据持久化功能
- UI 样式可以根据设计需求进行调整

## 许可证

MIT License
